library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CNTxALU is
  Port (
    clk_100MHz,A: in STD_LOGIC;
    seg: out STD_LOGIC_VECTOR(6 downto 0);
    an: out STD_LOGIC_VECTOR(3 downto 0)
   );
end CNTxALU;
architecture Behavioral of CNTxALU is

component bin_to_bcd is 
    Port(
        binary_in: in std_logic_vector(9 downto 0);
        bcd_out: out std_logic_vector(15 downto 0));
end component;

component sev_seg  is 
    Port ( SSDI : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           seg_sel : out STD_LOGIC_VECTOR (3 downto 0);
           seg_out : out STD_LOGIC_VECTOR (6 downto 0));
end component; 

component TENxCOUNTER is
  Port ( 
	CLK,RST,PRE,CNTDIR,CNT: IN STD_LOGIC;
	PREVAL: IN STD_LOGIC_VECTOR (9 downto 0);
	COUNT_OUT: OUT STD_LOGIC_VECTOR(9 downto 0)
	);
end component;      


signal bcdOut: std_logic_vector(15 downto 0);
signal cntrOut: std_logic_vector(9 downto 0);
begin
    
    TxC: TENxCOUNTER port map(
        clk=>A,
        RST=>'0',
        PRE=>'0',
        CNTDIR=>'0',
        CNT=>'0',
        PREVAL=>"0000000000",
        COUNT_OUT=>cntrOut
    );
    
    BCD: bin_to_bcd port map(
        binary_in=>cntrOut,
        bcd_out => bcdOut
    );
    
    SSEG: sev_seg port map(
            SSDI=>bcdOut,
            clk=>clk_100MHz,
            seg_out=>seg,
            seg_sel=>an
        );

end Behavioral;
