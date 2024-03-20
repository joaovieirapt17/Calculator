library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
--use ieee.numeric_std.all;

entity statemachine is
port(
    clk: in std_logic;
    switch: in std_logic_vector (1 downto 0);
    buttons: in std_logic_vector (3 downto 0);
    
    op_A, op_B: out std_logic_vector (1 downto 0);
    op: out std_logic_vector(1 downto 0);
    sel_out: out std_logic_vector (1 downto 0)
);
end statemachine;

architecture Behavioral of statemachine is
type state is (state_opa, state_op, state_opb, state_res); -- Operando A, Operador, Operando B e Resultado
    signal pr_state, nx_state: state;
begin

sequential_part: process(clk)
    begin
        pr_state <= state_opa;  -- Estado por defeito
        if(clk'event and clk = '1') then
            pr_state <= nx_state;
        end if;
     end process sequential_part;
     
combinational_part: process(buttons, switch, pr_state)
    begin
        case pr_state is
            when state_opa =>
                if(buttons(3) = '1') then
                    nx_state <= state_op;
                else
                    nx_state <= state_opa;
                end if;
                op_A <= (0 => switch(0), others => switch(1)); -- Operando A toma o valor presente nos switches

                sel_out <= "00"; -- Seletor do multiplexador toma o valor do primeiro estado para futuramente indicar nos LEDs
                
            when state_op =>
                if(buttons(2) = '1') then
                    nx_state <= state_opb;
                else
                    nx_state <= state_op;
                end if;
                op <= switch; -- Operador toma o valor presente nos switches
                sel_out <= "01"; -- Seletor do multiplexador toma o valor do segundo estado para futuramente indicar nos LEDs
                
            when state_opb =>
                if(buttons(1) = '1') then
                        nx_state <= state_res;
                    else
                        nx_state <= state_opb;
                    end if;
                    op_b <= (0 => switch(0), others => switch(1)); -- Operando B toma o valor presente nos switches e repete o bit mais significativo
                    sel_out <= "10"; -- Seletor do multiplexador toma o valor do terceiro estado para futuramente indicar nos LEDs
                    
            when state_res =>
                if(buttons(0) = '1') then
                    nx_state <= state_opa;
                else
                    nx_state <= state_res;
                end if;
                sel_out <= "11"; -- Seletor do multiplexador toma o valor do primeiro estado para futuramente indicar nos LEDs
        end case;

    end process combinational_part;

end Behavioral;
