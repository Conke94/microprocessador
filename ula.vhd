library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
    port (   
        x,y : in unsigned(15 downto 0);
        out_a :  out unsigned(15 downto 0);
        operation : in unsigned(1 downto 0);
        flag_zero: out std_logic
    );  
 end entity;

 architecture a_ula of ula is
    signal result : unsigned(15 downto 0);
    begin
        result <= x+y when operation = "00" else
                  x-y when operation = "01" else
                  shift_left(x, to_integer(y)) when operation = "10";

        out_a <= result;

        flag_zero <= '1' when result = "0000000000000000" else 
                     '0';
 end architecture;

-- FLAG CARRY, UMA OPERAÇÃO