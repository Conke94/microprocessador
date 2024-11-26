library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture a_processador_tb of processador_tb is 
    component microprocessador
        port(
            clk, reset : in std_logic
        );
    end component;

    constant period : time := 100 ns;
    signal finished : std_logic := '0';

    signal clk, reset : std_logic;
    signal ula_zero, ula_carry : std_logic;

    begin
        uut: microprocessador port map (
            clk => clk, reset => reset
        );

        reset_global : process
        begin
            reset <= '1';
            wait for period*2;
            reset <= '0';
            wait;
        end process reset_global;

        sim_time_proc : process
        begin
            wait for 10 us;
            finished <= '1';
            wait;
        end process sim_time_proc;

        clock_proc: process
        begin
            while finished /= '1' loop
                clk <= '0';
                wait for period / 2;
                clk <= '1';
                wait for period / 2;
            end loop;
            wait;
        end process clock_proc;

        process
            begin 
                wait;
        end process;
end architecture;