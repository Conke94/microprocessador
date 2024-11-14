library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microprocessador_tb is
end entity;

architecture a_microprocessador_tb of microprocessador_tb is 
    component microprocessador
        port(
            clk, reset, wr_en : in std_logic;
            reg_read, reg_wr: in unsigned(2 downto 0);
            operation : unsigned(1 downto 0);
            data_in : in unsigned(15 downto 0);
            ula_zero, ula_carry : out std_logic;
            imm : in unsigned(15 downto 0);
            sel_imm : in std_logic
        );
    end component;

    constant period : time := 100 ns;
    signal finished : std_logic := '0';

    signal imm : unsigned(15 downto 0) := "0000000000000000";
    signal data_in : unsigned(15 downto 0);
    signal clk, reset, wr_en : std_logic;
    signal reg_wr, reg_read : unsigned(2 downto 0);
    signal operation : unsigned(1 downto 0);
    signal ula_zero, ula_carry : std_logic;
    signal sel_imm : std_logic := '0';

    begin
        uut: microprocessador port map (
            data_in => data_in, imm => imm,
            clk => clk, reset => reset, wr_en => wr_en,
            reg_wr => reg_wr, reg_read => reg_read,
            operation => operation,
            ula_zero=>ula_zero, ula_carry=>ula_carry, sel_imm=>sel_imm
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
                data_in <= "0000000000000001";
                reg_wr <= "000";
                reg_read <= "000";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "0000000000000011";
                reg_wr <= "001";
                reg_read <= "000";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "0000000000000111";
                reg_wr <= "010";
                reg_read <= "000";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "0000000000001111";
                reg_wr <= "011";
                reg_read <= "000";
                wr_en <= '1';
                wait for 100 ns;
                data_in <= "0000000000011111";
                reg_wr <= "100";
                reg_read <= "000";
                wr_en <= '1';
                wait for 100 ns;
                wr_en<='0';
                reg_read<="000";
                wait for 100 ns;
                wr_en <= '0';
                sel_imm <= '0';
                operation <= "00";
                reg_read <= "000";
                wait for 200 ns;
                sel_imm <= '0';
                operation <= "00";
                reg_read <= "010";
                wait for 200 ns;
                sel_imm <= '0';
                operation <= "01";
                reg_read <= "001";
                wait for 200 ns;
                sel_imm <= '1';
                operation <= "00";
                reg_read <= "000";
                imm <= "1100000000000000";
                wait for 200 ns;
                sel_imm <= '0';
                operation <= "00";
                reg_read <= "000";
                imm <= "1100000000000000";
                wait for 200 ns;
                wait;
        end process;
end architecture;