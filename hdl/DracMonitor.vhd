--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DracMonitor.vhd
-- File history:
--      v00: June 23, 2020: first version
--      v01: Sept 27, 2020: cleaned some unused signals. Added comments 
--      v02: Nov. 5,  2020: Added/changed signal interface to TimeStampManager 																		
--      v03: Dec.10,  2020: Added registers for SVT 																		
--
-- Description: DRAC registers drivers and controller.
--
-- <Description here>
--   Interface between DCS packets from DTC and DRAC ROC. It replace RocMonitor inside TopSerdes 
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS_ES> <Package::FCG1152>
-- Author: Monica Tecchio
--
--------------------------------------------------------------------------------

library IEEE;	  							
USE IEEE.std_logic_1164.ALL;				 
USE IEEE.numeric_std.ALL;			  			 
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
								 					   
library work;
use work.algorithm_constants.all; 

entity DracMonitor is
   Generic (			 
      gAPB_DWIDTH     		: integer := 16;  
      gAPB_AWIDTH     		: integer := 16;	 
      gSERDES_DWIDTH  		: integer := 20; 
      gENDEC_DWIDTH   		: integer := 16;	
      IO_SIZE         		: integer := 2
   ); 
port (
    --<port_name> : <direction> <type>;
   ALGO_CLK                 : IN  std_logic;            -- 40 MHz clock
   RESET_N                  : IN  std_logic;
   
   -- Algo interface: reserved to monitor other modules inside Top_Serdes 								  
   ALGO_RESET				   : OUT std_logic; 		
   ALGO_ADDR     	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);  	-- address -1 reserved for turning off output bus of all algo blocks 
   ALGO_WDATA   	   		: OUT std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   	   
   ALGO_RDATA				   : IN  std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);   

   -- XCVR Monitor of Core_PCS signals
   ALIGNED       	   		: IN std_logic;   
   INVALID_K         	   : IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
   RX_K_CHAR        	      : IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
   CODE_ERR_N        	   : IN std_logic_vector(IO_SIZE-1 DOWNTO 0);		
   B_CERR          	   	: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
   RD_ERR          	   	: IN std_logic_vector(IO_SIZE-1 DOWNTO 0);	
   TX_CLK_STABLE	         : IN std_logic;  
   XCVR_LOSS_COUNTER		   : IN std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
   RESET_XCVR_ERRORS		   : OUT std_logic;

   --DCS FIFOs interface					  															
   DCS_RCV_FIFO_EMPTY		: IN  std_logic;            													
   DCS_RCV_FIFO_FULL		   : IN  std_logic;    	
   DCS_RCV_FIFO_Q			   : IN  std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH DOWNTO 0);    --Valid | LastPacket |Opcode[34:32] | Addr(31:16) | WData(15:0)	 
   DCS_RCV_FIFO_RE 		   : OUT  std_logic;             													 		
   DCS_RESP_FIFO_DATA      : OUT std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH DOWNTO 0);   -- DCS_RCV_FIFO_EMPTY(36) | Last Packet | Opcode[34:32] | Addr(31:16) | RData(15:0)	
   DCS_RESP_FIFO_WE 		   : OUT  std_logic; 	
   DCS_ALIGNMENT_REQ       : OUT std_logic;

   --Timestamp Manager
   EVENT_START_DELAY_FINE	:	OUT	std_logic_vector(gAPB_DWIDTH - 1 downto 0);
	EVENT_START_DELAY_FINE_EN	:	OUT	std_logic;						-- ALGO_ADDR can drive only 15 LSB, plus but(14) reserved fofr enable => max value is 2**14 = 16384 
	TIMESTAMP_IN				:	IN		std_logic_vector(gAPB_DWIDTH - 1 downto 0);
	
   -- ResetController signals
   SEL_RST						: OUT STD_LOGIC;
   SEL_RST_CNTL				: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
  
   -- Debugging
   DEBUG_REG_0			   	: IN  std_logic_vector(15 downto 0);
   PREREAD_PULSE	      	: OUT STD_LOGIC;
   
   -- uncomment to drive LED in Eval board
   --RESET_LED				: OUT std_logic;
   
   -- DRAC specific registers
	DDR_DDR3_FULL				: IN	std_logic;								-- stays highes from WRITE_PAGE_NO written to memory until all read out. Read via addr=11.
	TEMPFIFO_EMPTY				: IN	std_logic;								-- status of TEMPFIFO empty (contain 1kB page on the way to DDR). Read via addr=12, bit[0].
	TEMPFIFO_FULL				: IN	std_logic;								-- status of TEMPFIFO full  (contain 1kB page on the way to DDR). Read via addr=12, bit[1].
	MEMFIFO_EMPTY				: IN	std_logic;								-- status of MEMFIFO empty  (contain 1kB page on the way out of DDR). Read via addr=12, bit[2].
	MEMFIFO_FULL				: IN	std_logic;								-- status of MEMFIFO full  (contain 1kB page on the way out of DDR). Read via addr=12, bit[3].
	MEM_WR_CNT					: IN  std_logic_vector(15 downto 0);	-- no. of 1KB pages written to DR3 memory. Read via addr=13.
	MEM_RD_CNT					: IN  std_logic_vector(15 downto 0);	-- no. of 1KB pages read from DR3 memory. Read via addr=14.
	FIFO_RD_CNT					: IN  std_logic_vector(15 downto 0);	-- no. of data payload packets. Read via addr=15. (NB: this is the number of FIFO_RD_EN/2!)
	DCS_SIM_EN					: OUT std_logic;								-- enable simulation of configuration and DataReq protocol via DCS (addr=8, bit[4])
	DREQ_SIM_EN					: OUT std_logic;								-- enable simulation of Data Request Protocol via serial (addr=8, bit[8])
   DCS_ROCRESETN				: OUT STD_LOGIC;								-- specific firmware reset (separate from TOP_Serdes reset, although it does drive EXT_RST_N)
	DCS_WRITE_MEM_EN			: OUT std_logic;								-- enable write of data to memory
	DCS_READ_MEM_EN			: OUT std_logic;								-- enable read of 1 kB page from memory (ie simulates DATA_REQUEST from DTC)
	DCS_MEMFIFO_RDEN			: OUT std_logic;								-- enable memory data to TOP_SERDES (ie simulates DATA_REPLY to DTC)
	DCS_PATTERN_EN				: OUT std_logic;								-- switch between DIGIFIFO/PATTERN_FIFO inputs to memory when 0/1 (addr=8, bit[3])
   DCS_PATTERN					: OUT std_logic_vector(1 downto 0);		-- pattern generator type: 0=>+1, 1=>-1, 2=>A's,  3=>5's (addr=8, bit[1,0])
   DCS_WRITE_PAGE_NO			: OUT std_logic_vector(19 downto 0)	   -- MAX. no of 1kB pages wirtten to memory.  NB: ALGO_ADDR can drive only 15 LSB (ie MAX = 2**15 = 32768).
																						-- Use two addresses to write/read 12 LSB (addr 9) and 8 MSB (addr 10) with a DTC double write/read packet.
   );
end DracMonitor;

architecture arch of DracMonitor is

   -- signal, component etc. declarations
   
   signal writeCounter			: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
   signal readCounter			: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);	
   signal read_data				: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);			

   signal algo_addr_sig			: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 
   signal algo_wdata_sig		: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0);
   signal algo_reset_latch		: std_logic;

   signal drac_mon_addrs		: std_logic_vector(gAPB_AWIDTH-1 DOWNTO 0);   
   signal drac_mon_wdata		: std_logic_vector(gAPB_DWIDTH-1 DOWNTO 0); 	
   
   signal dcs_data				: std_logic_vector(gAPB_AWIDTH+gAPB_DWIDTH DOWNTO 0);
   signal dcs_selected			: std_logic;
   signal dcs_we, dcs_re		: std_logic;
   signal dcs_selected_cnt		: unsigned(2 downto 0);			

   signal evtstart_delay_fine_reg	: std_logic_vector(gAPB_DWIDTH-1 downto 0);
   signal evtstart_delay_en_reg		: std_logic;
	
	signal dcs_sim_reg			: std_logic;
	signal dreq_sim_reg			: std_logic;
	signal pattern_en_reg		: std_logic;
   signal pattern_reg			: std_logic_vector(gAPB_DWIDTH-1 downto 0);
   signal write_page_reg_LSB	: std_logic_vector(gAPB_DWIDTH-1 downto 0);
   signal write_page_reg_MSB	: std_logic_vector(gAPB_DWIDTH-1 downto 0);

   signal ram_we					: std_logic;
   signal ram_addr				: std_logic_vector(7 downto 0);
   signal ram_wdata				: std_logic_vector(7 downto 0);
   signal ram_rdata				: std_logic_vector(7 downto 0);

   signal fifo_we					: std_logic;
   signal fifo_re					: std_logic;
   signal fifo_full				: std_logic;	
   signal fifo_empty				: std_logic;	
   signal fifo_wdata				: std_logic_vector(7 downto 0);
   signal fifo_rdata				: std_logic_vector(7 downto 0);
   
   signal reset_sig				: std_logic;
   signal reset_sig_latch		: std_logic;
   signal reset_cntl				: std_logic_vector(9 downto 0);
   signal reset_cntl_latch		: std_logic_vector(9 downto 0);

	-- uncomment for Eval board
   --signal resetn_cnt				: std_logic_vector(31 downto 0);
	--signal reset_seen				: std_logic;

begin
   -- architecture body
   
   drac_mon_addrs <= dcs_data(gAPB_AWIDTH+gAPB_DWIDTH-1 downto gAPB_DWIDTH); 
   drac_mon_wdata <= dcs_data(gAPB_DWIDTH-1 downto 0);

   ALGO_ADDR		<= algo_addr_sig;		
   ALGO_WDATA		<= algo_wdata_sig;

   -------------------------------------------------------------------------------
   --(1) ALGO RESET sequence
   --	it will be initiated by sending DCS Write Request to addr 0x00
   -------------------------------------------------------------------------------			
   process (ALGO_CLK)
   begin		
	
      if (rising_edge(ALGO_CLK)) then
         ALGO_RESET         <= '0'; 
         algo_reset_latch   <= ALGO_RESET;
      
      -- Outside RESET
		-- comment A block and uncomment B block for EVAL board
		-- A block
         if (RESET_N = '0') then	   	 
            ALGO_RESET <= '1';	
         end if;
        
		-- B block			
         --if (RESET_N = '0') then	   	 
            --ALGO_RESET <= '1';	
            --reset_seen <= '0';
         --end if;
        --
         --if (algo_reset_latch and not ALGO_RESET) then   -- on ALGO_RESET falling edge
            --reset_seen  <= '1';
         --end if;   
--
         --if (reset_seen = '1') then
            --resetn_cnt <= resetn_cnt + 1;
         --end if;
      --
         --if (resetn_cnt = x"00FFFFFF") then
            --reset_seen <= '0';
            --resetn_cnt <= (others => '0'); 
         --end if;
			
      end if;      
   end process;		

   -------------------------------------------------------------------------------
   -- Process Read/Write Commands
   -------------------------------------------------------------------------------
   process (ALGO_CLK)
   begin	

      if rising_edge(ALGO_CLK) then	
   
         DCS_RCV_FIFO_RE   <= '0'; 	
         DCS_RESP_FIFO_WE  <= '0'; 
      
         dcs_we         <= '0';	
         dcs_re         <= '0';
         PREREAD_PULSE  <= '0';
         read_data      <= (others => '0');
            
         reset_sig         <= '0';
         reset_sig_latch   <=  reset_sig;
         reset_cntl        <= (others => '0');
         reset_cntl_latch  <=  reset_cntl;
         -- widen these ignals to make sure they can be latch on the 40 MHZ clock derived from the oscillator
         SEL_RST           <=  reset_sig or reset_sig_latch;
         SEL_RST_CNTL      <=  reset_cntl or reset_cntl_latch;
         
         DCS_ALIGNMENT_REQ	<= '0';
         RESET_XCVR_ERRORS <= '0';	

			EVENT_START_DELAY_FINE		<= evtstart_delay_fine_reg;   
			EVENT_START_DELAY_FINE_EN	<= evtstart_delay_en_reg;

			DCS_ROCRESETN		<= '1';
			DCS_WRITE_MEM_EN	<=	'0';
			DCS_READ_MEM_EN	<= '0';
			DCS_MEMFIFO_RDEN	<= '0';
			DCS_SIM_EN			<=	dcs_sim_reg;
			DREQ_SIM_EN			<=	dreq_sim_reg;
			DCS_PATTERN_EN		<= pattern_en_reg;
			DCS_PATTERN			<= pattern_reg(1 downto 0);
			DCS_WRITE_PAGE_NO	<= write_page_reg_MSB(7 downto 0) & write_page_reg_LSB(11 downto 0);		

         ram_we            <= '0';
         fifo_we           <= '0';
         fifo_re           <= '0';

-- uncomment for Eval board
         --RESET_LED          <= reset_seen;
 
         if (RESET_N = '0') then	
            dcs_selected      <= '0';
            dcs_we 				<= '0';
            dcs_re				<= '0';
            dcs_selected_cnt	<= (others => '0');
            writeCounter 		<= (others => '0');  
            readCounter 		<= (others => '0'); 
         
            algo_wdata_sig    <= (others => '0');
            algo_addr_sig     <= (others => '0');
         
            evtstart_delay_fine_reg		<= (others => '0');
				evtstart_delay_en_reg   	<= '0';				  
														   
				dcs_sim_reg			<= '0';	
				dreq_sim_reg		<= '0';	
				pattern_en_reg		<= '0';	
            pattern_reg			<= (others => '0');
            write_page_reg_LSB<= (others => '0');
            write_page_reg_MSB<= (others => '0');

            ram_wdata         <= (others => '0');
            ram_addr          <= (others => '0');
            fifo_wdata        <= (others => '0');
         else
      
         -- control exchange of signals between input FIFO (DCS_RCV) and output FIFO (DCS_RESP)
            if(dcs_selected = '1') then        -- handle dcs command mode
         
            -- use counter as state machine											  
               dcs_selected_cnt <= dcs_selected_cnt + 1;
            
               if (dcs_selected_cnt = 0) then		
               -- DCS Rcv FIFO Data Format:
               --      W/R (32) | Addr(31:16) | WData(15:0)	
               -- DCS Resp FIFO Data Format:
               -- 		DCS_RCV_FIFO_EMPTY(32)  Addr(31:16) | RData(15:0)	
                  dcs_data <= DCS_RCV_FIFO_Q;			
                  if (DCS_RCV_FIFO_Q(32) = '0') then	
                     PREREAD_PULSE	 	<= '1';
                  end if;			
            
               elsif (dcs_selected_cnt = 1) then -- data must be ready out of FIFO 
               
                  if (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH) = '1') then 		
                     dcs_we 		<= '1';	   	-- write				  	-- write
                  elsif (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH)= '0') then 	    
                     dcs_re         <= '1'; 						        -- read	
                  end if;	
                           
-- MT changed:  
--   DCS_SELECTED_CNT=2 is too early to save data to DCS_RESP_FIFO for block read operations
--   But there is no point in delaying also WR operations...so keep early DSC_SELECTED disable for those! 
--               elsif (dcs_selected_cnt = 2) then  							-- read data should be in read_data by now.  	  				
--               --Write Packet to DCS
--                  if (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH) = '0') then   -- write flag is '0' => READ OP
--                     DCS_RESP_FIFO_WE 			<= '1';	  
--                     DCS_RESP_FIFO_DATA 		<= DCS_RCV_FIFO_EMPTY & drac_mon_addrs & read_data;      
--                  end if;	   		   
--                  dcs_selected <= '0'; -- done!
               elsif (dcs_selected_cnt = 2) then  						 	  				
                  if (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH) = '1') then
                     dcs_selected <= '0';
                  end if;
               elsif (dcs_selected_cnt = 4) then  	-- only now read_data is ready for block operations ... Write Packet to DCS
                  if (dcs_data(gAPB_AWIDTH+gAPB_DWIDTH) = '0') then   -- write flag is '0' => READ OP
                     DCS_RESP_FIFO_WE 			<= '1';	  
                     DCS_RESP_FIFO_DATA 		<= DCS_RCV_FIFO_EMPTY & drac_mon_addrs & read_data;      
                  end if;	   		   
                  dcs_selected <= '0'; -- done!
               end if;					
               
            end if;	-- if(dcs_selected = '1')
            
            ----------------------------------			
            -- DCS REGISTER WRITE
            ----------------------------------	
            if (dcs_selected = '1' and dcs_we = '1') then	
 
               writeCounter <= writeCounter + 1;
               
               -- 0...7 are reserved registers to deal with other modules inside TOP_SERDES
               if (drac_mon_addrs = 0) then		    --RESET ALL
                  reset_sig         <= '1';
                  reset_cntl	    <= (others => '1');
               elsif (drac_mon_addrs = 1) then		    -- SELECTIVE RESET 
                  reset_sig         <= '1';
                  reset_cntl	    <= drac_mon_wdata(9 downto 0);	  -- any bit high issues reset to the associated block 
               elsif (drac_mon_addrs = 2) then			 -- reserved to drive ALGO_ADDR in module write/read 
                  algo_addr_sig <= drac_mon_wdata;
               elsif (drac_mon_addrs = 3) then			 -- reserved to drive ALGO_WDATA in module write/read
                  algo_wdata_sig <= drac_mon_wdata;
               elsif (drac_mon_addrs = 4) then
                  DCS_ALIGNMENT_REQ <= '1';   		-- self clearing	  
               elsif (drac_mon_addrs = 5) then
                  evtstart_delay_en_reg	<= drac_mon_wdata(14);				  
						evtstart_delay_fine_reg	<= "00" & drac_mon_wdata(13 downto 0);	
               elsif (drac_mon_addrs = 6) then
                  RESET_XCVR_ERRORS			<= '1';	-- self clearing			  
            
               -- 8...255 are reserved for DRAC controls and registers
               elsif (drac_mon_addrs = 8) then
                  pattern_reg 	<= B"000X_0000_000X_00" & drac_mon_wdata(1 downto 0);
                  pattern_en_reg	<= drac_mon_wdata(3);				  
						dcs_sim_reg		<= drac_mon_wdata(4);				  
						dreq_sim_reg	<= drac_mon_wdata(8);	
               elsif (drac_mon_addrs = 9) then
                  write_page_reg_LSB <= X"0" & drac_mon_wdata(11 downto 0);
                elsif (drac_mon_addrs = 10) then
                  write_page_reg_MSB <= X"00" & drac_mon_wdata(7 downto 0);
               elsif (drac_mon_addrs = 11) then
						DCS_WRITE_MEM_EN	<= '1';	 -- self clearing
               elsif (drac_mon_addrs = 12) then
						DCS_READ_MEM_EN	<= '1';	 -- self clearing
               elsif (drac_mon_addrs = 13) then
						DCS_MEMFIFO_RDEN	<= '1';	 -- self clearing
               elsif (drac_mon_addrs = 14) then
						DCS_ROCRESETN			<= '0';	 -- self clearing
               elsif (drac_mon_addrs = 126) then
                  fifo_we   <= '1';
                  fifo_wdata <= drac_mon_wdata(7 downto 0);
                elsif (drac_mon_addrs >= 127 and drac_mon_addrs <255) then   -- allow for one register per straw
                  ram_we    <= '1';
                  ram_addr  <= drac_mon_addrs(7 downto 0);
                  ram_wdata <= drac_mon_wdata(7 downto 0);
               end if;
               
            ----------------------------------			
            -- DCS REGISTER READ
            ----------------------------------	
            elsif (dcs_selected = '1' and dcs_we = '0') then  -- N.B. dcs_we = 0 is default state while dcs_we/dcs_re are set only at dcs_selected_cnt=1
                                                               -- This is not a problem for constant registers to read BUT for fifo/ram reads, we needs
                                                               -- 1) a single clock pulse  2) a pulse one clock BEFORE latching FIFO_RDATA
               if (dcs_re = '1') then 	             
                  readCounter <= readCounter + 1;  
               end if;	
               
-- MT moved to default value at ALGO_CLK rising edge 
--               read_data <= (others => '0');

               -- 0...7 are reserved registers to deal with other modules inside TOP_SERDES
               if (drac_mon_addrs = 0) then	-- monitors status of Core_PCS	 						
                  read_data 	<= DEBUG_REG_0;			
               elsif (drac_mon_addrs = 1) then	
                  read_data 	<=  ALGO_RDATA;	-- data read from other modules
               elsif (drac_mon_addrs = 2) then	
                  read_data 	<=  writeCounter ;	-- useful counters
               elsif (drac_mon_addrs = 3) then	 
                  read_data 	<=  readCounter; 	
               elsif (drac_mon_addrs = 4) then		 	 
                  read_data <=   "00" &  RX_K_CHAR & 
                                 "00" & ALIGNED & TX_CLK_STABLE & 
                                 INVALID_K & RD_ERR & B_CERR & CODE_ERR_N;
               elsif (drac_mon_addrs = 5) then		 	 
                  read_data 	<= XCVR_LOSS_COUNTER;			
					elsif (drac_mon_addrs = 6) then		 	 
                  read_data 	<= TIMESTAMP_IN;			
     
               -- 8...255 are reserved for DRAC controls and registers
               elsif (drac_mon_addrs = 8) then		 	 
                  read_data <= B"0000_000" & dreq_sim_reg & "000" & dcs_sim_reg & pattern_en_reg & "0" & pattern_reg(1 downto 0);	
               elsif (drac_mon_addrs = 9) then		 	 
                  read_data <= write_page_reg_LSB;	
               elsif (drac_mon_addrs = 10) then		 	 
                  read_data <= write_page_reg_MSB;	
               elsif (drac_mon_addrs = 11) then
						read_data	<=	B"0000_0000_0000_000" & DDR_DDR3_FULL;
               elsif (drac_mon_addrs = 12) then
						read_data	<= B"0000_0000_0000" & MEMFIFO_FULL & MEMFIFO_EMPTY & TEMPFIFO_FULL & TEMPFIFO_EMPTY;
               elsif (drac_mon_addrs = 13) then
						read_data	<= MEM_WR_CNT;
               elsif (drac_mon_addrs = 14) then
						read_data	<= MEM_RD_CNT;
               elsif (drac_mon_addrs = 15) then
						read_data	<= FIFO_RD_CNT;
					elsif (drac_mon_addrs = 126) then		 	 
                  fifo_re   <= PREREAD_PULSE;
                  read_data <= "00000000" & fifo_rdata;
               elsif (drac_mon_addrs >= 127 and drac_mon_addrs <255) then   -- allow for one register per straw
                  ram_we    <= '0';
                  ram_addr  <= drac_mon_addrs(7 downto 0);
                  read_data <= "00000000" & ram_rdata;							-- only 8-bit ram data allowed!!
               else	
                  read_data <= drac_mon_addrs;		  --Unmapped Addresses
               end if;								  							   		   

            elsif (dcs_selected = '0' and DCS_RCV_FIFO_EMPTY = '0') then
            
               DCS_RCV_FIFO_RE <= '1';	  
               dcs_selected <= '1'; 	
               dcs_selected_cnt <= (others => '0');
            
            end if;    -- if (dcs_selected = '1' and dcs_we = '1')
            
         end if;       -- if (RESET_N = '0')
      
      end if;           -- if rising_edge(ALGO_CLK)

   end process;		


-- instantiate example RAM, 8b x 128 deep   
   example_ram: entity work.sync_ram(RTL)
   port map (
      clock   => ALGO_CLK,
      we      => ram_we,
      address => ram_addr(6 downto 0),
      datain  => ram_wdata,
      dataout => ram_rdata
   );
   
-- instantiate syn_fifo.vhd, 8b x 256
   example_fifo: entity work.syn_fifo(RTL)
   port map(
      CLK       => ALGO_CLK,
      RST       => not RESET_N,
      DataIn    => fifo_wdata,
      ReadEn    => fifo_re,
      WriteEn   => fifo_we,
      Empty     => fifo_empty,
      Full      => fifo_full,
      DataOut   => fifo_rdata
   );
   
end architecture;