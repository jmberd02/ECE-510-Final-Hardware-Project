--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Sun Dec  8 15:21:05 2019
--Host        : DESKTOP-V61H4BB running 64-bit major release  (build 9200)
--Command     : generate_target ALU_wrapper.bd
--Design      : ALU_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ALU_wrapper is
  port (
    RESET : in STD_LOGIC;
    clk_100MHz : in STD_LOGIC;
    gpio_rtl_0_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gpio_rtl_1_tri_i : in STD_LOGIC_VECTOR ( 21 downto 0 );
    uart_rtl_0_rxd : in STD_LOGIC;
    uart_rtl_0_txd : out STD_LOGIC
  );
end ALU_wrapper;

architecture STRUCTURE of ALU_wrapper is
  component ALU is
  port (
    gpio_rtl_0_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    uart_rtl_0_rxd : in STD_LOGIC;
    uart_rtl_0_txd : out STD_LOGIC;
    RESET : in STD_LOGIC;
    clk_100MHz : in STD_LOGIC;
    gpio_rtl_1_tri_i : in STD_LOGIC_VECTOR ( 21 downto 0 )
  );
  end component ALU;
begin
ALU_i: component ALU
     port map (
      RESET => RESET,
      clk_100MHz => clk_100MHz,
      gpio_rtl_0_tri_o(15 downto 0) => gpio_rtl_0_tri_o(15 downto 0),
      gpio_rtl_1_tri_i(21 downto 0) => gpio_rtl_1_tri_i(21 downto 0),
      uart_rtl_0_rxd => uart_rtl_0_rxd,
      uart_rtl_0_txd => uart_rtl_0_txd
    );
end STRUCTURE;
