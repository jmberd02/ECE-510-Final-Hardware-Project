--Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
--Date        : Sun Dec  8 14:05:11 2019
--Host        : DESKTOP-V61H4BB running 64-bit major release  (build 9200)
--Command     : generate_target Overall_wrapper.bd
--Design      : Overall_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Overall_wrapper is
  port (
    RST : in STD_LOGIC;
    clk_100MHz : in STD_LOGIC;
    gpio_rtl_0_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    uart_rtl_0_rxd : in STD_LOGIC;
    uart_rtl_0_txd : out STD_LOGIC
  );
end Overall_wrapper;

architecture STRUCTURE of Overall_wrapper is
  component Overall is
  port (
    clk_100MHz : in STD_LOGIC;
    uart_rtl_0_rxd : in STD_LOGIC;
    uart_rtl_0_txd : out STD_LOGIC;
    gpio_rtl_0_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    RST : in STD_LOGIC
  );
  end component Overall;
begin
Overall_i: component Overall
     port map (
      RST => RST,
      clk_100MHz => clk_100MHz,
      gpio_rtl_0_tri_o(15 downto 0) => gpio_rtl_0_tri_o(15 downto 0),
      uart_rtl_0_rxd => uart_rtl_0_rxd,
      uart_rtl_0_txd => uart_rtl_0_txd
    );
end STRUCTURE;
