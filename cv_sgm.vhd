library ieee;
use ieee.std_logic_1164.all;

entity cv_sgm is

  port (
    clk_i           : in  std_logic;
    clk_en_3m58_i   : in  std_logic;
    reset_n_i       : in  std_logic;
    sgm_ac_ram_n_i  : in  std_logic;
    sgm_ac_bios_n_i : in  std_logic;
    a_i             : in  std_logic_vector(6 downto 0);
    d_i             : in  std_logic_vector(7 downto 0);
    sgm_en_ram_n_o  : out std_logic;
    sgm_en_bios_n_o : out std_logic
  );

end cv_sgm;


architecture rtl of cv_sgm is

  signal sgm_en_ram_n_q  : std_logic;
  signal sgm_en_bios_n_q : std_logic;

begin

  -----------------------------------------------------------------------------
  -- Process seq
  --
  -- Purpose:
  --   Implements the Super Game Module enables for main RAM and BIOS overlay RAM
  --
  seq: process (clk_i, reset_n_i)
    variable sgm_en_ram_n_v  : std_logic;
    variable sgm_en_bios_n_v : std_logic;
  begin
    if reset_n_i = '0' then
      sgm_en_ram_n_q <= '0';
      sgm_en_bios_n_q <= '0';
    elsif clk_i'event and clk_i = '1' then
      if clk_en_3m58_i = '1' then
        if sgm_ac_ram_n_i = '0' then
          sgm_en_ram_n_q <= not d_i(0);
        end if;
        if sgm_ac_bios_n_i = '0' then
          sgm_en_bios_n_q <= d_i(1);
        end if;
      end if;
    end if;
  end process seq;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- SGM ram enable lines
  -----------------------------------------------------------------------------
  sgm_en_ram_n_o  <= sgm_en_ram_n_q;
  sgm_en_bios_n_o <= sgm_en_bios_n_q;

end rtl;

