library IEEE;
use IEEE.STD_LOGIC_1164.all;            
use IEEE.NUMERIC_STD.all;                  

package algorithm_constants is
	
    ----==================================----
    -- Declaration of
    -- constants, types, signals etc.         
		 					 
 	constant gAPB_DWIDTH     		: integer := 16;  
	constant gAPB_AWIDTH     		: integer := 16;	 
 	constant gSERDES_DWIDTH  		: integer := 20; 
 	constant gENDEC_DWIDTH   		: integer := 16;	
	constant IO_SIZE         		: integer := 2;
													 
	constant EVENT_WINDOW_TAG_SIZE	: integer := 48;
	
	-- External DCS Block Address
 	constant ALGO_WADDR_WIDTH   	: natural := 8;	  
 	constant ALGO_LOCADDR_WIDTH   	: natural := 8;	  
 	constant ALGO_WDATA_WIDTH   	: natural := gAPB_DWIDTH;	 	 
 	constant ALGO_RADDR_WIDTH   	: natural := 8;	  		   
	 
	constant NUM_OF_TCLK_IN_40		: integer := 5; 
	 
	 	 
 	constant ALGO_VERSION		  	: std_logic_vector(7 downto 0) := x"01";	 
	 
	 --FIFO Parameters
	constant DCS_FIFO_ADDR_SIZE			: integer := 9;
	constant NORMAL_FIFO_ADDR_SIZE		: integer := 9;  
	
	constant DCS_FIFO_ADDR_DEPTH		: integer := 256;
	constant NORMAL_FIFO_ADDR_DEPTH		: integer := 256;  		 
	
	-- RAM Retransmission Parameters
	constant RAM_ADDR_WIDTH					: integer := 8;
	constant RAM_ADDR_DEPTH 				: integer := 256;
	
	-- Data Request	Parameters
	constant DATAREQ_DWIDTH				: integer := 64;
	 	
    ----==================================----	   
	-- Packet Types
	constant PACKET_TYPE_DCSRequest 			:  natural := 0;	  
	constant PACKET_TYPE_Heartbeat 				:  natural := 1;
	constant PACKET_TYPE_DataRequest 			:  natural := 2;
	constant PACKET_TYPE_DCSReply 				:  natural := 4;
	constant PACKET_TYPE_DataHeader 			:  natural := 5;
	constant PACKET_TYPE_DataPayload 			:  natural := 6;
	constant PACKET_TYPE_DCSWritePayload 		:  natural := 7;
	constant PACKET_TYPE_DCSReadPayload 		:  natural := 8;
	
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
		ret := algo_data(ALGO_WDATA_WIDTH-1 downto 0);					  
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
