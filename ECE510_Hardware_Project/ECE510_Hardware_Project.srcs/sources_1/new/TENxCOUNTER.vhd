library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity TENxCOUNTER is
  Port ( 
	CLK,RST,PRE,CNTDIR,CNT: IN STD_LOGIC;
	PREVAL: IN STD_LOGIC_VECTOR (8 downto 0);
	COUNT_OUT: OUT STD_LOGIC_VECTOR(8 downto 0)
	);
end TENxCOUNTER;

architecture Behavioral of TENxCOUNTER is

signal count : std_logic_vector(8 downto 0):=(others =>'0');
begin
	process(CLK,RST,PRE,CNTDIR,CNT,PREVAL)
	begin
		if(rising_edge(CLK) AND RST = '0') then
			if(PRE='1') then
				count <= PREVAL;
			else
				if(CNTDIR = '0') then
					count <= count +1;
				else
					count <= count -1;
				end if;
			end if;
		end if;	
	end process;
	
	COUNT_OUT <= "00000000" WHEN RST = '1'
	       else count when RST = '0';

end Behavioral;
