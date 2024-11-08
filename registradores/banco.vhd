library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banco is
    port(
        clk, reset, wr_en : in std_logic;
        reg_wr: in unsigned(2 downto 0);
        reg_read: in unsigned(2 downto 0);
        data_in : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
end entity;

architecture a_banco of banco is 
    component reg16bits is
        port(
            clk, reset, wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;
    signal registro: unsigned(15 downto 0);
    SIGNAL wr_en0, wr_en1, wr_en2, wr_en3, wr_en4 : std_logic := '0';
    SIGNAL data0, data1, data2, data3, data4 : unsigned(15 DOWNTO 0) := "0000000000000000";
    begin
        reg0 : reg16bits PORT MAP(clk => clk, reset => reset, wr_en => wr_en0, data_in => data_in, data_out => data0);
        reg1 : reg16bits PORT MAP(clk => clk, reset => reset, wr_en => wr_en1, data_in => data_in, data_out => data1);
        reg2 : reg16bits PORT MAP(clk => clk, reset => reset, wr_en => wr_en2, data_in => data_in, data_out => data2);
        reg3 : reg16bits PORT MAP(clk => clk, reset => reset, wr_en => wr_en3, data_in => data_in, data_out => data3);
        reg4 : reg16bits PORT MAP(clk => clk, reset => reset, wr_en => wr_en4, data_in => data_in, data_out => data4);

        wr_en0 <= '1' when wr_en = '1' and reg_wr = "000" else '0';
        wr_en1 <= '1' when wr_en = '1' and reg_wr = "001" else '0';
        wr_en2 <= '1' when wr_en = '1' and reg_wr = "010" else '0';
        wr_en3 <= '1' when wr_en = '1' and reg_wr = "011" else '0';
        wr_en4 <= '1' when wr_en = '1' and reg_wr = "100" else '0';

        data_out <= data0 when reg_read = "000" else
                    data1 when reg_read = "001" else
                    data2 when reg_read = "010" else
                    data3 when reg_read = "011" else
                    data4 when reg_read = "100" else
                    "0000000000000000";

end architecture;