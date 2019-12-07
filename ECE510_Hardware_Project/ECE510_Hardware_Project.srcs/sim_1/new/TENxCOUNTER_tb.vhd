----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2019 10:17:26 AM
-- Design Name: 
-- Module Name: TENxCOUNTER_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TENxCOUNTER_tb is
--  Port ( );
end TENxCOUNTER_tb;

architecture Behavioral of TENxCOUNTER_tb is
component TENxCOUNTER 
    generic (n:integer:=9);
    port(
    CLK,RST,PRE,CNTDIR,CNT: IN STD_LOGIC;
    PREVAL: IN STD_LOGIC_VECTOR(n downto 0);
    COUNT_OUT: OUT STD_LOGIC_VECTOR(n downto 0));
end component;

signal sig_clk,sig_rst,sig_pre,sig_cntdir,sig_cnt: STD_LOGIC:='0';
signal sig_preval:std_logic_vector(9 downto 0):="1010101010";
signal sig_count_out:std_logic_vector(9 downto 0):="0000000000";

begin

    uut:TENxCOUNTER port map(
        clk => sig_clk,
        rst => sig_rst,
        pre => sig_pre,
        cntdir =>sig_cntdir,
        cnt => sig_cnt,
        preval => sig_preval,
        count_out => sig_count_out);
    
    clock:process
    begin
        wait for 25 ns;
        sig_clk <= not sig_clk;
    end process;
    
    asynch_reset:process
    begin
    end process;
    
    synch_preset:process
    begin
    end process;
    
    switch_countdir:process
    begin end process;
    
    cnt_what:process
    begin end process;
    
    
   
end Behavioral;
