
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity clk_divider is
PORT(
    clk : in std_logic;
        
    clk_1hz : out std_logic
);
end clk_divider;

architecture Behavioral of clk_divider is
        
begin
    
    count: process(clk)
        variable counter: std_logic_vector(26 downto 0);
    begin
    -- Quando ocorre um clock soma 1 no contador
    if(clk'event and clk = '1') then
        counter := counter + 1;
    end if;
    clk_1hz <= counter(26); 
    
    end process count;

end Behavioral;
