library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port (   
        x,y : in unsigned(15 downto 0);
        out_a :  out unsigned(15 downto 0);
        operation : in unsigned(1 downto 0);
        flag_carry: out std_logic;
        flag_zero: out std_logic
    );  
 end entity;

 architecture a_ula of ula is
    signal result : unsigned(15 downto 0);
    signal carry_sum, carry_sub : std_logic;
    signal x_increased, y_increased, sum_increased: unsigned(16 downto 0);

    begin
        x_increased <= '0' & x; y_increased <= '0' & y;
        sum_increased <= x_increased + y_increased;

        carry_sum <= sum_increased(16);
        carry_sub <= '0' WHEN y <= x ELSE '1';

        flag_carry <= carry_sum WHEN operation = "00" else 
                      carry_sub WHEN operation = "01" else
                      '0';

        -- Faz a operação escolhida
        result <= x+y when operation = "00" else
                  x-y when operation = "01" else
                  shift_right(x, to_integer(y)) when operation = "10" else
                  x xor y when operation = "11" else
                  x;


        -- Atualiza a flag zero
        flag_zero <= '1' when result = 0 else 
                  '0';


        -- Retorna a saída
        out_a <= result;
 end architecture;