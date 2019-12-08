library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;



entity bin_to_bcd is
    Port(
        binary_in: in std_logic_vector(9 downto 0);
        bcd_out: out std_logic_vector(15 downto 0)
    );
end entity;


architecture bbcd of bin_to_bcd is

signal bcdInteger,b1,b2,b3,b4: integer;
signal thou, hund, ten, one: std_logic_vector (3 downto 0):="0000";

begin
    bcdInteger <= to_integer(unsigned(binary_in));
    
    b1 <=(bcdInteger )mod 10;
    b2 <=(bcdInteger/10 )mod 10;
    b3 <=(bcdInteger/100 )mod 10;
    b4 <=(bcdInteger/1000 )mod 10;
    
    one <= std_logic_vector(to_unsigned(b1,one'length));
    ten <= std_logic_vector(to_unsigned(b2,one'length));
    hund <= std_logic_vector(to_unsigned(b3 mod 10,one'length));
    thou <= std_logic_vector(to_unsigned(b4 mod 10,one'length));


    bcd_out <= thou & hund & ten & one;

end bbcd; 