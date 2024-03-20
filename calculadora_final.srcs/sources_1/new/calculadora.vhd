library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity calculadora is
    port( 
        sysclk: in std_logic;
        sw: in std_logic_vector(1 downto 0);
        btn: in std_logic_vector(3 downto 0);
        led: out std_logic_vector(3 downto 0);
        led4_b, led4_g, led4_r, led5_b, led5_g, led5_r: out std_logic
    );
end calculadora;

architecture Behavioral of calculadora is
    COMPONENT statemachine is
        port( 
            clk: in std_logic;
            switch: in std_logic_vector (1 downto 0);
            buttons: in std_logic_vector (3 downto 0);
            op_A, op_B: out std_logic_vector (1 downto 0);
            op: out std_logic_vector(1 downto 0);
            sel_out: out std_logic_vector (1 downto 0)
        );
    END COMPONENT statemachine;

    COMPONENT ALU
        PORT( 
            op_A, op_B: in  STD_LOGIC_VECTOR (1 downto 0);
            op: in std_logic_vector(1 downto 0);
            res: out  STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT;
    
    COMPONENT clk_divider
        PORT( 
            clk : in std_logic;
            clk_1hz : out std_logic
        );
    END COMPONENT;

    COMPONENT display_mux
        PORT( 
            clk_1hz: in  STD_LOGIC;
            sel: in std_logic_vector(1 downto 0);
            op_A, op_B: in  STD_LOGIC_VECTOR (1 downto 0); 
            op: in STD_LOGIC_VECTOR (1 downto 0);
            res: in std_logic_vector(3 downto 0);
            led_out: out std_logic_vector(3 downto 0);
            led4_b, led4_g, led4_r, led5_b, led5_g, led5_r: out std_logic
        );
    END COMPONENT;

    signal op_A, op_B: std_logic_vector(1 downto 0);
    signal op: std_logic_vector(1 downto 0);
    signal res: std_logic_vector(3 downto 0);
    signal sel_display: std_logic_vector (1 downto 0);
    signal clk_1hz: std_logic;


begin

    statemachine1: statemachine PORT MAP(sysclk, sw, btn, op_A, op_B, op, sel_display);
    ALU1: ALU PORT MAP(op_A, op_B, op, res);
    clk_divider1: clk_divider PORT MAP(sysclk, clk_1hz);
    display_mux1: display_mux PORT MAP(clk_1hz, sel_display, op_A, op_B, op, res, led, led4_b, led4_g, led4_r, led5_b, led5_g, led5_r);

end Behavioral;