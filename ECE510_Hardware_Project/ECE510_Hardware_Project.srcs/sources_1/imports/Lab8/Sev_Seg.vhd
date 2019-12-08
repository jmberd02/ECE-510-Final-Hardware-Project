----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2019 11:34:28 PM
-- Design Name: 
-- Module Name: Sev_Seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sev_seg is
    Port ( SSDI : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           seg_sel : out STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out STD_LOGIC_VECTOR (6 downto 0));       
end sev_seg;

architecture Behavioral of sev_seg is

signal display : std_logic_vector(15 downto 0); --Hexadecimal number to be displayed on board
signal BHC : std_logic_vector(3 downto 0);  --Binary to Hex signal coming in 
signal Refresh_Rate : std_logic_vector(19 downto 0) := (others => '0'); --This allows us to have a 10 ns refresh 
signal choice : std_logic_vector(1 downto 0) := "00";
signal selector : std_logic_vector(3 downto 0);
   
begin   
   --Process for creating the refresh rate
    process(clk)
    begin
        if(rising_edge(clk)) then
            Refresh_Rate <= Refresh_Rate + 1;
        end if;
    end process;
    
 
     --Choosing which annode is active
    process(Refresh_Rate(10))
    begin
        if rising_edge(Refresh_Rate(10)) then
            seg_sel <= "1111";
            if choice = "00" then
                selector <= "1110";-- Far right
                BHC <= SSDI(3 downto 0);
            elsif choice = "01" then
                selector <= "1101";
                BHC <= SSDI(7 downto 4);
            elsif choice = "10" then
                selector <= "1011";
                BHC <= SSDI(11 downto 8);
            elsif choice = "11" then
                selector <= "0111";-- Far left
                BHC <= SSDI(15 downto 12);
             end if;
             case BHC is
                when "0000" => seg_out <= "1000000"; --0
                when "0001" => seg_out <= "1111001"; --1
                when "0010" => seg_out <= "0100100"; --2
                when "0011" => seg_out <= "0110000"; --3
                when "0100" => seg_out <= "0011001"; --4
                when "0101" => seg_out <= "0010010"; --5
                when "0110" => seg_out <= "0000010"; --6
                when "0111" => seg_out <= "1111000"; --7
                when "1000" => seg_out <= "0000000"; --8
                when "1001" => seg_out <= "0011000"; --9
                when others => seg_out <= "1111111";          
             end case;
            
            choice <= choice + 1;
            seg_sel <= selector;           
         end if;     
     end process;
     
end Behavioral;