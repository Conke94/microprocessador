library ieee;
use ieee.std_logic_1164.all;

entity mux8x1 is
    port(
        sel_a, sel_b, sel_c : in std_logic;
        in_a, in_b, in_c, in_d, in_e, in_f, in_g, in_h : in std_logic;
        out_a : out std_logic
    );
end entity;

architecture a_mux8x1 of mux8x1 is
    begin
        out_a <= in_a when sel_a = '0' and sel_b = '0' and sel_c = '0' else
                 in_b when sel_a = '0' and sel_b = '0' and sel_c = '1' else
                 in_c when sel_a = '0' and sel_b = '1' and sel_c = '0' else
                 in_d when sel_a = '0' and sel_b = '1' and sel_c = '1' else
                 in_e when sel_a = '1' and sel_b = '0' and sel_c = '0' else
                 in_f when sel_a = '1' and sel_b = '0' and sel_c = '1' else
                 in_g when sel_a = '1' and sel_b = '1' and sel_c = '0' else
                 in_h when sel_a = '1' and sel_b = '1' and sel_c = '1' else
                 '0';
end architecture;