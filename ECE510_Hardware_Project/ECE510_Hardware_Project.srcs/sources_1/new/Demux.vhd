library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Demux is
Port ( 
	PRE: IN STD_LOGIC_VECTOR (9 downto 0);
	SEL: IN STD_LOGIC;
	OUT1, OUT2: OUT STD_LOGIC_VECTOR(9 downto 0)
);
end Demux;

architecture dmux of Demux is
begin
    process (PRE,SEL)
    begin
        if (SEL = '1') then
            OUT1 <= PRE;
            OUT2 <= "0000000000";
         else
            OUT2 <= PRE;
            OUT1 <= "0000000000";
         end if;
    end process;
end dmux;