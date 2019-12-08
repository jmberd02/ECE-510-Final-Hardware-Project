library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity TENxCOUNTER is
  generic (n : integer := 9);		
  Port ( 
	CLK,RST,PRE,CNTDIR,CNT: IN STD_LOGIC;
	PREVAL: IN STD_LOGIC_VECTOR (n downto 0);
	COUNT_OUT: OUT STD_LOGIC_VECTOR(n downto 0)
	);
end TENxCOUNTER;

architecture Behavioral of TENxCOUNTER is
signal Q1, Q2, Q3,Q_OUT : std_logic;--from Coding Examples
signal count : std_logic_vector(n downto 0):=(others =>'0');
begin


--  Provides a one-shot pulse from a non-clock input, with reset
--**Insert the following between the 'architecture' and
---'begin' keywords**


--**Insert the following after the 'begin' keyword**
    debounce:process(clk)
    begin
        if (clk'event and clk = '1') then
          if (rst = '1') then
             Q1 <= '0';
             Q2 <= '0';
             Q3 <= '0';
          else
             Q1 <= cnt;
             Q2 <= Q1;
             Q3 <= Q2;
          end if;
        end if;
    end process;

    Q_OUT <= Q1 and Q2 and (not Q3);


	counter : process(CLK,RST,PRE,CNTDIR,CNT,PREVAL)
	begin
	   if (RST='1') then
	       count <= "0000000000";
       elsif(rising_edge(Q_OUT) AND RST /= '1') then
			if(PRE='1') then
			    if (PREVAL >= "1111101000") then
                    count <= "1111101000";
                else
				    count <= PREVAL;
                end if;
			else
				if(CNTDIR = '1') then
					if (count <= 0) then
					   count <= "1111101000";
                    else
                        count <= count -1;
                   end if;
				else
					if (count >= "1111101000") then
					   count <= (others => '0');
                    else
                        count <= count +1;
                   end if;
				end if;
			end if;
		end if;	
	end process;
	
	
	COUNT_OUT <= count;--"0000000000" WHEN RST = '1'
	       --else count;

end Behavioral;
