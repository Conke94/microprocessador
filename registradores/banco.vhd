library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits_tb is
end entity;

architecture a_reg16bits_tb of reg16bits_tb is 
    component reg16bits
        port(
            clk : in std_logic;
            reset : in std_logic;
            wr_en: in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    constant period : time := 100 ns;
    signal finished : std_logic := '0';
    signal data_in, data_out : unsigned(15 downto 0);
    signal clk, reset, wr_en : std_logic;

    begin
        uut: reg16bits port map (
            data_in => data_in, data_out => data_out,
            clk => clk, reset => reset,
            wr_en => wr_en
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
                wait for 200 ns;
                wr_en <= '0';
                data_in <= "1111111111111111";
                wait for 100 ns;
                wr_en <= '1';
                data_in <= "1111111111111111";
                wait for 200 ns;
                wr_en <= '1';
                data_in <= "1100110010000000";
                wait for 200 ns;
                wr_en <= '0';
                data_in <= "0000000000000000";
                wait for 200 ns;
                wait;
        end process;
end architecture;