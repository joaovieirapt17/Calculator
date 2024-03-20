library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_mux is
PORT( 
    clk_1hz: in  STD_LOGIC;
    sel: in std_logic_vector(1 downto 0);
    op_A, op_B: in  STD_LOGIC_VECTOR (1 downto 0); 
    op: in STD_LOGIC_VECTOR (1 downto 0);
    res: in std_logic_vector(3 downto 0);
    led_out: out std_logic_vector(3 downto 0);
    led4_b, led4_g, led4_r, led5_b, led5_g, led5_r: out std_logic
);
end display_mux;

architecture Behavioral of display_mux is

begin

combinational_part: process(clk_1hz, sel, op_A, op_B, op, res)
    begin
        case sel is
            when "00" =>
            
                led_out(0) <= op_A(0);
                led_out(1) <= op_A(1);
                led_out(2) <= op_A(1);
                led_out(3) <= op_A(1);
                led4_b <= '0';
                led4_g <= '0';
                led4_r <= '0';
                led5_b <= '0';
                led5_g <= '0';
                led5_r <= '1';
                
            when "01" =>
                led_out(0) <= op(0);
                led_out(1) <= op(1);
                led_out(2) <= '0';
                led_out(3) <= '0';
                led4_b <= '1';
                led4_g <= '0';
                led4_r <= '0';
                led5_b <= '1';
                led5_g <= '0';
                led5_r <= '0';
                
            when "10" =>
                led_out(0) <= op_B(0);
                led_out(1) <= op_B(1);
                led_out(2) <= op_B(1);
                led_out(3) <= op_B(1);
                led4_b <= '0';
                led4_g <= '0';
                led4_r <= '1';
                led5_b <= '0';
                led5_g <= '0';
                led5_r <= '0';
                
            when "11" =>
                led_out <= res;
                led4_b <= '0';
                led4_g <= clk_1hz;
                led4_r <= '0';
                led5_b <= '0';
                led5_g <= clk_1hz;
                led5_r <= '0';
  
        end case;

    end process combinational_part;


end Behavioral;
