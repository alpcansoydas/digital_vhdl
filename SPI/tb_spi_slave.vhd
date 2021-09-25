
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_spi_slave is
--  Port ( );
end tb_spi_slave;

architecture Behavioral of tb_spi_slave is
component spi_slave is
	port(
			rst			: in std_logic;	-- Asynch system reset
			-- Ports between Master and Slave
			sck			: in std_logic;	-- SPI clock signal sent by SPI Master
			mosi		: in std_logic;	-- Data signal comes from SPI Master
			ss			: in std_logic;	-- Slave select signal sent by SPI Master (Active-low)
			-- Outputs:
			miso		: out std_logic;	-- Data will be read after Master sends pre-determined number of SCK cycles	
			
			-- Ports between Slave and Interface FPGA
			tx_data	    : in std_logic_vector(7 downto 0);	-- Data that will be transmitted is packed here as 8-bit chunks
			rx_data		: out std_logic_vector(7 downto 0)	-- Received data from Master is packed here, will be sent to Interface FPGA
	);
end component;

signal rst			:  std_logic;	-- Asynch system reset
signal sck			:  std_logic;	-- SPI clock signal sent by SPI Master
signal mosi		    :  std_logic;	-- Data signal comes from SPI Master
signal ss			:  std_logic;	-- Slave select signal sent by SPI Master (Active-low)
signal miso		    :  std_logic;	-- Data will be read after Master sends pre-determined number of SCK cycles	
signal tx_data	    :  std_logic_vector(7 downto 0);	-- Data that will be transmitted is packed here as 8-bit chunks
signal rx_data		:  std_logic_vector(7 downto 0);	-- Received data from Master is packed here, will be sent to Interface FPGA

begin

 uut : spi_slave port map
    (        
        rst			=> rst		,
        sck			=> sck		,
        mosi		=> mosi		,
        ss			=> ss		, 
        miso		=> miso		,
        tx_data     => tx_data  ,
        rx_data     => rx_data   
    );
    
stim_proc: process
begin
    rst <= '1';
    sck <= '0';
    ss <= '1';
    mosi <= '0';
    wait for 50 ns;
    rst <= '0';
    wait for 20ns;
    
    -- SS--
    ss <= '0';
    tx_data <= x"55";
    wait for 10ns;
    
    mosi <= '1';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    mosi <= '0';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    mosi <= '1';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    mosi <= '0';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    mosi <= '1';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    mosi <= '0';
    wait for 5 ns;
    sck <= '1';
    wait for 5 ns;
    sck <= '0';
    wait for 5 ns;
    
    ss <= '1';
    
    wait;

end process;

end Behavioral;
