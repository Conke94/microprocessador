library ieee;
use ieee.std_logic_1164.all;

entity mux8x1_tb is
end entity;


architecture a_mux8x1 of mux8x1_tb is
    component mux8x1
        port(
            sel_a, sel_b, sel_c : in std_logic;
            in_a, in_b, in_c, in_d, in_e, in_f, in_g, in_h : in std_logic;
            out_a : out std_logic
        );
    end component;
    signal sel_a, sel_b, sel_c, in_a, in_b, in_c, in_d, in_e, in_f, in_g, in_h, out_a : std_logic;

    begin 
        uut: mux8x1 port map (
            sel_a => sel_a,
            sel_b => sel_b,
            sel_c => sel_c,
            in_a => '0',
            in_b => '0',
            in_c => in_c,
            in_d => '1',
            in_e => in_e,
            in_f => '0',
            in_g => in_g,
            in_h => '1',
            out_a => out_a
        );

        process
            begin 
                -- Saída A
                sel_a <= '0';
                sel_b <= '0';
                sel_c <= '0';
                in_c <= '0';
                in_e <= '0';
                in_g <= '0';
                wait for 50 ns;

                -- Saída B
                sel_a <= '0';
                sel_b <= '0';
                sel_c <= '1';
                in_c <= '0';
                in_e <= '1';
                in_g <= '0';
                wait for 50 ns;

                -- Saída C
                sel_a <= '0';
                sel_b <= '1';
                sel_c <= '0';
                in_c <= '0';
                in_e <= '1';
                in_g <= '0';
                wait for 50 ns;

                -- Saída D
                sel_a <= '0';
                sel_b <= '1';
                sel_c <= '1';
                in_c <= '0';
                in_e <= '1';
                in_g <= '0';
                wait for 50 ns;
                
                -- Saída E
                sel_a <= '1';
                sel_b <= '0';
                sel_c <= '0';
                in_c <= '0';
                in_e <= '1';
                in_g <= '0';
                wait for 50 ns;

                -- Saída F
                sel_a <= '1';
                sel_b <= '0';
                sel_c <= '1';
                in_c <= '0';
                in_e <= '1';
                in_g <= '0';
                wait for 50 ns;

                -- Saída G
                sel_a <= '1';
                sel_b <= '1';
                sel_c <= '0';
                in_c <= '0';
                in_e <= '1';
                in_g <= '0';
                wait for 50 ns;

                -- Saída H
                sel_a <= '1';
                sel_b <= '1';
                sel_c <= '1';
                in_c <= '0';
                in_e <= '1';
                in_g <= '0';
                wait for 50 ns;
                
                wait;
    end process;    
end architecture;



