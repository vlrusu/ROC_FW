library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all;                  

package algorithm_constants is
	
    ----==================================----
    -- Declaration of
    -- constants, types, signals etc.         
    
	constant CMDHEADER  : std_logic_vector(15 downto 0) := x"AABB"; -- header for start of DTC command to processor
	constant CMDTRAILER : std_logic_vector(15 downto 0) := x"FFEE"; -- trailer for end of of DTC command to processor
	constant CMDERROR 	: std_logic_vector(15 downto 0) := x"DEAD"; -- error word for DTC command
	constant MAX_CMD_LENGHT : std_logic_vector(15 downto 0) := x"1FFB"; -- max. DTC command lenght in unit of 16-bit payload


 	constant gAPB_DWIDTH     		: integer := 16;  
	constant gAPB_AWIDTH     		: integer := 16;	 
 	constant gSERDES_DWIDTH  		: integer := 20; 
 	constant gENDEC_DWIDTH   		: integer := 16;	
	constant IO_SIZE         		: integer := 2;
   
	constant EVENT_WINDOW_TAG_SIZE	: integer := 48;
	constant EVENT_WINDOW_PACKET_SIZE: integer := 11;  -- max. ROC Event size in units of 128-bit DTC packets 
   
	-- External DCS Block Address
 	constant ALGO_WADDR_WIDTH   	: natural := 8;	  
 	constant ALGO_LOCADDR_WIDTH     : natural := 8;	  
 	constant ALGO_WDATA_WIDTH   	: natural := gAPB_DWIDTH;	 	 
 	constant ALGO_RADDR_WIDTH   	: natural := 8;	  		   
	 
	constant NUM_OF_TCLK_IN_40		: integer := 5; 
	 
 	constant ALGO_VERSION		  	: std_logic_vector(7 downto 0) := x"01";	 
	 
	 --FIFO Parameters
	constant DCS_FIFO_ADDR_SIZE		: integer := 9;
	constant NORMAL_FIFO_ADDR_SIZE	: integer := 9;
	
	constant DCS_FIFO_ADDR_DEPTH	: integer := 256;
	constant NORMAL_FIFO_ADDR_DEPTH	: integer := 256;  		 
	
	-- RAM Retransmission Parameters
	constant RAM_ADDR_WIDTH			: integer := 8;
	constant RAM_ADDR_DEPTH 		: integer := 256;
	
	-- Data Request	Parameters
	constant DATAREQ_DWIDTH			: integer := 64;
   

   -- tracker specific Paramenter
    constant EVENT_TAG_BITS	    : integer := 48;  -- max. Event Window count for duration of experiment 
	constant SPILL_TAG_BITS	    : integer := 20;  -- EWTAG counter for duration of SPILL	
	constant TRK_HIT_BITS	    : integer := 8;   -- max. no of tracker hits per Event Window (or 2**8-1 = 255)	
	constant EVENT_SIZE_BITS    : integer := 10;  -- max. tracker Event size in units of 64-bit AXI beats (or 2**10 - 1 = 1023)
	constant DDR_ADDRESS_BITS   : integer := 20;  -- max. no of 1 kB blocks in 8 Gb DDR memory (or 2**20 - 1 = 1048575)
	constant MAX_STEP_BITS	    : integer := 3;   -- number of 1kB blocks needed to fit the maximum trackers event size (or 2**3 + 1 = 9 blocks) 
	constant DIGI_BITS	        : integer := 32;  -- ROCFIFO output width
	constant AXI_BITS	        : integer := 64;  -- AXI beat size
   
   constant FIFO_DATA_SIZE  		   : integer := 40;  -- fits size for 3 events
   constant ROCFIFO_DEPTH  		   : integer := 17;  -- fits 65K 32-bit words

   
    ----==================================----	   
	-- Packet Types
	constant PACKET_TYPE_DCSRequest 		:  natural := 0;	  
	constant PACKET_TYPE_Heartbeat 			:  natural := 1;
	constant PACKET_TYPE_DataRequest 		:  natural := 2;
	constant PACKET_TYPE_DCSReply 			:  natural := 4;
	constant PACKET_TYPE_DataHeader 		:  natural := 5;
	constant PACKET_TYPE_DataPayload 		:  natural := 6;
	constant PACKET_TYPE_DCSWritePayload 	:  natural := 7;
	constant PACKET_TYPE_DCSReadPayload 	:  natural := 8;
	
	 ----==================================----
	---- Marker Types	  
--	constant DTC_MARKER_EVENT				:  std_logic_vector(15 downto 0) := "1C10";
--	constant DTC_MARKER_CLOCK				:  std_logic_vector(15 downto 0) := "1C11";
--	constant DTC_MARKER_LOOPBACK 			:  std_logic_vector(15 downto 0) := "1C12";	
--	
--	constant DTC_MARKER_TIMEOUT 			:  std_logic_vector(15 downto 0) := "1C13";
--	constant ROC_MARKER_ERROR				:  std_logic_vector(15 downto 0) := "1C13";
--	
	 	  
    ----==================================----
	-- functions
	function extract_algo_waddr( algo_addr : std_logic_vector) return unsigned;	 
	function extract_algo_locaddr( algo_addr : std_logic_vector) return unsigned;  
	function extract_algo_wdata( algo_data : std_logic_vector) return std_logic_vector;	  
	function extract_algo_we( algo_data : std_logic_vector) return std_logic;
		
end algorithm_constants;                                                                           
 
package body algorithm_constants is
	
	-- Definition of previously declared
	    -- constants
	    -- subprograms   
	                                                                          
	        
	----==================================----
	----==================================---- extract_algo_waddr
	----==================================----																							 
	function extract_algo_waddr( algo_addr : std_logic_vector) return unsigned is
	    variable ret : unsigned(ALGO_WADDR_WIDTH-1 downto 0);
	begin							  
		ret := unsigned(algo_addr(algo_addr'length-1 downto algo_addr'length-ALGO_WADDR_WIDTH));					  
		return ret;
	end function;
	
	----==================================----
	----==================================---- extract_algo_locaddr
	----==================================----																							 
	function extract_algo_locaddr( algo_addr : std_logic_vector) return unsigned is
	    variable ret : unsigned(ALGO_LOCADDR_WIDTH-1 downto 0);
	begin							  
		ret := unsigned(algo_addr(ALGO_LOCADDR_WIDTH-1 downto 0));					  
		return ret;
	end function;		 	
	
	----==================================----
	----==================================---- extract_algo_wdata
	----==================================----																							 
	function extract_algo_wdata( algo_data : std_logic_vector) return std_logic_vector is
	    variable ret : std_logic_vector(ALGO_WDATA_WIDTH-1 downto 0);
	begin	
--    MT changed:  only LSB 15-bit are valid data a bit[15] is reserved for WE!   
--		ret := algo_data(ALGO_WDATA_WIDTH-1 downto 0);					  
		ret := '0' & algo_data(ALGO_WDATA_WIDTH-2 downto 0);					  
		return ret;
	end function;				
	
	----==================================----
	----==================================---- extract_algo_we
	----==================================----																							 
	function extract_algo_we( algo_data : std_logic_vector) return std_logic is
	    variable ret : std_logic;
	begin							  
		ret := algo_data(algo_data'length-1);					  
		return ret;
	end function;
	
	        
end algorithm_constants;
