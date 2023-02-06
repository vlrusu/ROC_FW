-- This is automatically generated file --

LIBRARY ieee; 
  USE ieee.std_logic_1164.all; 
  USE ieee.numeric_std.all; 
  

ENTITY SIZE_FIFO_SIZE_FIFO_0_ram_wrapper IS 
  GENERIC( RWIDTH    		: integer := 18;   
           WWIDTH    		: integer := 18;   
           RDEPTH    		: integer := 1024; 
           WDEPTH    		: integer :=1024;  
           SYNC      		: integer :=0;     
           SYNC_RESET      : integer := 0;     
           RAM_OPT      	: integer := 0;     
           CTRL_TYPE 		: integer :=1;     
           PIPE      		: integer := 1 );  
  PORT( 
    WDATA  : IN std_logic_vector(WWIDTH -1 downto 0); 
    WADDR  : IN std_logic_vector(WDEPTH -1 downto 0); 
    WEN    : IN std_logic; 
    REN    : IN std_logic; 
    RDATA  : OUT std_logic_vector(RWIDTH -1 downto 0); 
    RADDR  : IN std_logic_vector(RDEPTH -1 downto 0); 
    RESET_N: IN std_logic; 
    CLOCK  : IN std_logic; 
    RCLOCK : IN std_logic; 
A_SB_CORRECT         : OUT std_logic;   
B_SB_CORRECT         : OUT std_logic;   
A_DB_DETECT          : OUT std_logic;   
B_DB_DETECT          : OUT std_logic;   
    WCLOCK : IN std_logic 
  ); 
END SIZE_FIFO_SIZE_FIFO_0_ram_wrapper; 

ARCHITECTURE generated OF SIZE_FIFO_SIZE_FIFO_0_ram_wrapper IS 

COMPONENT SIZE_FIFO_SIZE_FIFO_0_USRAM_top
PORT (
R_DATA                  : OUT std_logic_vector(RWIDTH-1 DOWNTO 0);   
W_DATA                   : IN std_logic_vector(WWIDTH-1 DOWNTO 0);   
R_ADDR                  : IN std_logic_vector(RDEPTH-1 DOWNTO 0);   
W_ADDR                  : IN std_logic_vector(WDEPTH-1 DOWNTO 0);   
BLK_EN                   : IN std_logic;   
W_EN                   : IN std_logic;  
W_CLK                   : IN std_logic;   
R_CLK                   : IN std_logic;   
R_ADDR_ARST_N                  : IN std_logic;   
R_ADDR_EN               : IN std_logic);   
END COMPONENT;
SIGNAL RDATA_xhdl1              :  std_logic_vector(RWIDTH - 1 DOWNTO 0);   

BEGIN 

RDATA <= RDATA_xhdl1;

U2_asyncnonpipe : SIZE_FIFO_SIZE_FIFO_0_USRAM_top 
PORT MAP (
R_DATA => RDATA_xhdl1,
W_DATA => WDATA,       
R_ADDR => RADDR,      
W_ADDR => WADDR,      
BLK_EN => REN,         
W_EN => WEN,         
W_CLK => WCLOCK,      
R_CLK => RCLOCK,      
R_ADDR_ARST_N    => RESET_N,    
R_ADDR_EN => REN);     


END ARCHITECTURE generated;
