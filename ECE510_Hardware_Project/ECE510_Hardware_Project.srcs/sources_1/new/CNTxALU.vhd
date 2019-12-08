library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CNTxALU is
  Port (
    clk_100MHz,btnC,uart_rx: in STD_LOGIC;
    sw: in STD_LOGIC_VECTOR(15 downto 0);
    uart_tx: out STD_LOGIC;
    seg: out STD_LOGIC_VECTOR(6 downto 0);
    an: out STD_LOGIC_VECTOR(3 downto 0);
    gpio_o: out STD_lOGIC_VECTOR(15 downto 0)
   );
end CNTxALU;
architecture Behavioral of CNTxALU is

component demux is Port(
    PRE: IN STD_LOGIC_VECTOR (9 downto 0);
	SEL: IN STD_LOGIC;
	OUT1, OUT2: OUT STD_LOGIC_VECTOR(9 downto 0)
	);
end component;

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

component ALU_wrapper is
    port(
    RESET : in STD_LOGIC;
    clk_100MHz : in STD_LOGIC;
    gpio_rtl_1_tri_i : in STD_LOGIC_VECTOR ( 21 downto 0 );
    gpio_rtl_0_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    uart_rtl_0_rxd : in STD_LOGIC;
    uart_rtl_0_txd : out STD_LOGIC
    );
end component;


signal bcdOut: std_logic_vector(15 downto 0);
signal cntrOut: std_logic_vector(9 downto 0);
signal gpio_i:std_logic_vector(21 downto 0);
signal demux_to_alu: std_logic_vector(9 downto 0);
signal demux_to_cntr: std_logic_vector(9 downto 0);
begin
    
    dem: demux port map(
       PRE => sw(9 downto 0),
	   SEL => sw(12),
	   OUT1 => demux_to_alu,
	   OUT2 =>demux_to_cntr
	   );
    
    TxC: TENxCOUNTER port map(
        clk=>clk_100MHz,
        RST=>sw(15),
        PRE=>sw(14),
        CNTDIR=>sw(13),
        CNT=>btnC,
        PREVAL=>demux_to_cntr,
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
    
    gpio_i_gen:process(demux_to_alu,sw(11 downto 10),cntrout)
    begin
        gpio_i(9 downto 0) <= demux_to_alu;
        gpio_i(11 downto 10) <= sw(11 downto 10);
        gpio_i(21 downto 12) <= cntrout; 
    end process;
        
        
    ALU: ALU_wrapper port map(
        RESET => sw(15),
        clk_100MHz => clk_100MHz,
        gpio_rtl_1_tri_i => gpio_i,
        gpio_rtl_0_tri_o =>gpio_o,
        uart_rtl_0_rxd =>uart_rx,
        uart_rtl_0_txd => uart_tx
        );    

end Behavioral;
