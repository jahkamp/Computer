library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity rw_96x8_xync is 

 port(clock,write      :in std_logic;
       address,data_in  :in std_logic_vector(7 downto 0);
       data_out         :out std_logic_vector(7 downto 0));
  
end entity;


architecture rw_96x8_xync_arch of rw_96x8_xync is
  
  signal EN     : std_logic;
  
  
 	type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
	
	signal RW : rw_type;
	
  
  
  begin
    
    
    
RWCHECK : process(address)
  begin
    if((to_integer(unsigned(address)) >= 128) and 
		   (to_integer(unsigned(address)) <= 223))then 
			EN <= '1';
		else
			EN <= '0';
		end if;
	end process;
	
DATA_MEMORY : process(clock)
  begin
    if (rising_edge(clock)) then
      if(EN = '1' and write = '1') then
        RW(to_integer(unsigned(address))) <= data_in;
      elsif(EN = '1' and write = '0') then
        data_out <= RW(to_integer(unsigned(address)));
      end if;
    end if;
  end process;

    
  end architecture;