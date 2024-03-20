library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU is
PORT(
    op_A, op_B: in  STD_LOGIC_VECTOR (1 downto 0);
    op: in std_logic_vector(1 downto 0);
    res: out  STD_LOGIC_VECTOR (3 downto 0)
);
end ALU;

architecture Behavioral of ALU is
begin
 process (op_A, op_B, op)
        variable temp_result : INTEGER;
    begin
        case op is
            when "00" =>
                temp_result := to_integer(signed(op_A)) + to_integer(signed(op_B));-- CASO seja 00 a variavel op vai fazer a soma dos dois operandos e por o resultado no temp result
            when "01" =>
                temp_result := to_integer(signed(op_A)) - to_integer(signed(op_B));-- caso seja 01 a variavel op, vai fazer a subtração dos dois operandos e por o resultado no temp_result 
            when "10" =>
                temp_result := to_integer(signed(op_A)) * to_integer(signed(op_B));-- caso seja 10 vai fazer a mutiplicação 
            when others =>
                temp_result := to_integer(signed(op_A)) * to_integer(signed(op_B));-- caso seja 11 vai fazer a multiplicação
        end case;

        res <= std_logic_vector(to_unsigned(temp_result, res'length));-- a variavel res vai ser igual ao temp_result
    end process;


end Behavioral;


