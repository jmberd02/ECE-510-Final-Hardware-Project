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

signal count : std_logic_vector(n downto 0):=(others =>'0');
begin
	counter : process(CLK,RST,PRE,CNTDIR,CNT,PREVAL)
	begin
	   if(RST='1') then
	       count<= "000000000";
	   end if;
		if(rising_edge(CLK) AND RST /= '1') then
			if(PRE='1') then
				count <= PREVAL;
			else
				if(CNTDIR = '1') then
					count <= count -1;
				else
					count <= count +1;
				end if;
			end if;
		end if;	
	end process;
	
	
	COUNT_OUT <= "000000000" WHEN RST = '1'
	       else count;

end Behavioral;
