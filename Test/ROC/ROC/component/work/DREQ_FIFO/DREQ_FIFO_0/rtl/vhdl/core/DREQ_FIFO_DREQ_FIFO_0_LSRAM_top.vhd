-- Version: 2022.3 2022.3.0.8

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity DREQ_FIFO_DREQ_FIFO_0_LSRAM_top is

    port( W_DATA : in    std_logic_vector(39 downto 0);
          R_DATA : out   std_logic_vector(39 downto 0);
          W_ADDR : in    std_logic_vector(15 downto 0);
          R_ADDR : in    std_logic_vector(15 downto 0);
          W_EN   : in    std_logic;
          R_EN   : in    std_logic;
          W_CLK  : in    std_logic;
          R_CLK  : in    std_logic
        );

end DREQ_FIFO_DREQ_FIFO_0_LSRAM_top;

architecture DEF_ARCH of DREQ_FIFO_DREQ_FIFO_0_LSRAM_top is 

  component RAM1K20
    generic (MEMORYFILE:string := ""; RAMINDEX:string := ""; 
        INIT0:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT1:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT2:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT3:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT4:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT5:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT6:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT7:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT8:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT9:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT10:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT11:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT12:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT13:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT14:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT15:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT16:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT17:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT18:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT19:std_logic_vector(1023 downto 0) := (others => 'X')
        );

    port( A_DOUT        : out   std_logic_vector(19 downto 0);
          B_DOUT        : out   std_logic_vector(19 downto 0);
          DB_DETECT     : out   std_logic;
          SB_CORRECT    : out   std_logic;
          ACCESS_BUSY   : out   std_logic;
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_BLK_EN      : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_CLK         : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(19 downto 0) := (others => 'U');
          A_REN         : in    std_logic := 'U';
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_DOUT_EN     : in    std_logic := 'U';
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_BLK_EN      : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(19 downto 0) := (others => 'U');
          B_REN         : in    std_logic := 'U';
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_DOUT_EN     : in    std_logic := 'U';
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          ECC_EN        : in    std_logic := 'U';
          BUSY_FB       : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_BYPASS      : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_BYPASS      : in    std_logic := 'U';
          ECC_BYPASS    : in    std_logic := 'U'
        );
  end component;

  component OR4
    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal \R_DATA_TEMPR0[0]\, \R_DATA_TEMPR1[0]\, 
        \R_DATA_TEMPR2[0]\, \R_DATA_TEMPR3[0]\, 
        \R_DATA_TEMPR0[1]\, \R_DATA_TEMPR1[1]\, 
        \R_DATA_TEMPR2[1]\, \R_DATA_TEMPR3[1]\, 
        \R_DATA_TEMPR0[2]\, \R_DATA_TEMPR1[2]\, 
        \R_DATA_TEMPR2[2]\, \R_DATA_TEMPR3[2]\, 
        \R_DATA_TEMPR0[3]\, \R_DATA_TEMPR1[3]\, 
        \R_DATA_TEMPR2[3]\, \R_DATA_TEMPR3[3]\, 
        \R_DATA_TEMPR0[4]\, \R_DATA_TEMPR1[4]\, 
        \R_DATA_TEMPR2[4]\, \R_DATA_TEMPR3[4]\, 
        \R_DATA_TEMPR0[5]\, \R_DATA_TEMPR1[5]\, 
        \R_DATA_TEMPR2[5]\, \R_DATA_TEMPR3[5]\, 
        \R_DATA_TEMPR0[6]\, \R_DATA_TEMPR1[6]\, 
        \R_DATA_TEMPR2[6]\, \R_DATA_TEMPR3[6]\, 
        \R_DATA_TEMPR0[7]\, \R_DATA_TEMPR1[7]\, 
        \R_DATA_TEMPR2[7]\, \R_DATA_TEMPR3[7]\, 
        \R_DATA_TEMPR0[8]\, \R_DATA_TEMPR1[8]\, 
        \R_DATA_TEMPR2[8]\, \R_DATA_TEMPR3[8]\, 
        \R_DATA_TEMPR0[9]\, \R_DATA_TEMPR1[9]\, 
        \R_DATA_TEMPR2[9]\, \R_DATA_TEMPR3[9]\, 
        \R_DATA_TEMPR0[10]\, \R_DATA_TEMPR1[10]\, 
        \R_DATA_TEMPR2[10]\, \R_DATA_TEMPR3[10]\, 
        \R_DATA_TEMPR0[11]\, \R_DATA_TEMPR1[11]\, 
        \R_DATA_TEMPR2[11]\, \R_DATA_TEMPR3[11]\, 
        \R_DATA_TEMPR0[12]\, \R_DATA_TEMPR1[12]\, 
        \R_DATA_TEMPR2[12]\, \R_DATA_TEMPR3[12]\, 
        \R_DATA_TEMPR0[13]\, \R_DATA_TEMPR1[13]\, 
        \R_DATA_TEMPR2[13]\, \R_DATA_TEMPR3[13]\, 
        \R_DATA_TEMPR0[14]\, \R_DATA_TEMPR1[14]\, 
        \R_DATA_TEMPR2[14]\, \R_DATA_TEMPR3[14]\, 
        \R_DATA_TEMPR0[15]\, \R_DATA_TEMPR1[15]\, 
        \R_DATA_TEMPR2[15]\, \R_DATA_TEMPR3[15]\, 
        \R_DATA_TEMPR0[16]\, \R_DATA_TEMPR1[16]\, 
        \R_DATA_TEMPR2[16]\, \R_DATA_TEMPR3[16]\, 
        \R_DATA_TEMPR0[17]\, \R_DATA_TEMPR1[17]\, 
        \R_DATA_TEMPR2[17]\, \R_DATA_TEMPR3[17]\, 
        \R_DATA_TEMPR0[18]\, \R_DATA_TEMPR1[18]\, 
        \R_DATA_TEMPR2[18]\, \R_DATA_TEMPR3[18]\, 
        \R_DATA_TEMPR0[19]\, \R_DATA_TEMPR1[19]\, 
        \R_DATA_TEMPR2[19]\, \R_DATA_TEMPR3[19]\, 
        \R_DATA_TEMPR0[20]\, \R_DATA_TEMPR1[20]\, 
        \R_DATA_TEMPR2[20]\, \R_DATA_TEMPR3[20]\, 
        \R_DATA_TEMPR0[21]\, \R_DATA_TEMPR1[21]\, 
        \R_DATA_TEMPR2[21]\, \R_DATA_TEMPR3[21]\, 
        \R_DATA_TEMPR0[22]\, \R_DATA_TEMPR1[22]\, 
        \R_DATA_TEMPR2[22]\, \R_DATA_TEMPR3[22]\, 
        \R_DATA_TEMPR0[23]\, \R_DATA_TEMPR1[23]\, 
        \R_DATA_TEMPR2[23]\, \R_DATA_TEMPR3[23]\, 
        \R_DATA_TEMPR0[24]\, \R_DATA_TEMPR1[24]\, 
        \R_DATA_TEMPR2[24]\, \R_DATA_TEMPR3[24]\, 
        \R_DATA_TEMPR0[25]\, \R_DATA_TEMPR1[25]\, 
        \R_DATA_TEMPR2[25]\, \R_DATA_TEMPR3[25]\, 
        \R_DATA_TEMPR0[26]\, \R_DATA_TEMPR1[26]\, 
        \R_DATA_TEMPR2[26]\, \R_DATA_TEMPR3[26]\, 
        \R_DATA_TEMPR0[27]\, \R_DATA_TEMPR1[27]\, 
        \R_DATA_TEMPR2[27]\, \R_DATA_TEMPR3[27]\, 
        \R_DATA_TEMPR0[28]\, \R_DATA_TEMPR1[28]\, 
        \R_DATA_TEMPR2[28]\, \R_DATA_TEMPR3[28]\, 
        \R_DATA_TEMPR0[29]\, \R_DATA_TEMPR1[29]\, 
        \R_DATA_TEMPR2[29]\, \R_DATA_TEMPR3[29]\, 
        \R_DATA_TEMPR0[30]\, \R_DATA_TEMPR1[30]\, 
        \R_DATA_TEMPR2[30]\, \R_DATA_TEMPR3[30]\, 
        \R_DATA_TEMPR0[31]\, \R_DATA_TEMPR1[31]\, 
        \R_DATA_TEMPR2[31]\, \R_DATA_TEMPR3[31]\, 
        \R_DATA_TEMPR0[32]\, \R_DATA_TEMPR1[32]\, 
        \R_DATA_TEMPR2[32]\, \R_DATA_TEMPR3[32]\, 
        \R_DATA_TEMPR0[33]\, \R_DATA_TEMPR1[33]\, 
        \R_DATA_TEMPR2[33]\, \R_DATA_TEMPR3[33]\, 
        \R_DATA_TEMPR0[34]\, \R_DATA_TEMPR1[34]\, 
        \R_DATA_TEMPR2[34]\, \R_DATA_TEMPR3[34]\, 
        \R_DATA_TEMPR0[35]\, \R_DATA_TEMPR1[35]\, 
        \R_DATA_TEMPR2[35]\, \R_DATA_TEMPR3[35]\, 
        \R_DATA_TEMPR0[36]\, \R_DATA_TEMPR1[36]\, 
        \R_DATA_TEMPR2[36]\, \R_DATA_TEMPR3[36]\, 
        \R_DATA_TEMPR0[37]\, \R_DATA_TEMPR1[37]\, 
        \R_DATA_TEMPR2[37]\, \R_DATA_TEMPR3[37]\, 
        \R_DATA_TEMPR0[38]\, \R_DATA_TEMPR1[38]\, 
        \R_DATA_TEMPR2[38]\, \R_DATA_TEMPR3[38]\, 
        \R_DATA_TEMPR0[39]\, \R_DATA_TEMPR1[39]\, 
        \R_DATA_TEMPR2[39]\, \R_DATA_TEMPR3[39]\, \BLKX0[0]\, 
        \BLKY0[0]\, \BLKX1[0]\, \BLKY1[0]\, \ACCESS_BUSY[0][0]\, 
        \ACCESS_BUSY[0][1]\, \ACCESS_BUSY[0][2]\, 
        \ACCESS_BUSY[0][3]\, \ACCESS_BUSY[0][4]\, 
        \ACCESS_BUSY[0][5]\, \ACCESS_BUSY[0][6]\, 
        \ACCESS_BUSY[0][7]\, \ACCESS_BUSY[0][8]\, 
        \ACCESS_BUSY[0][9]\, \ACCESS_BUSY[0][10]\, 
        \ACCESS_BUSY[0][11]\, \ACCESS_BUSY[0][12]\, 
        \ACCESS_BUSY[0][13]\, \ACCESS_BUSY[0][14]\, 
        \ACCESS_BUSY[0][15]\, \ACCESS_BUSY[0][16]\, 
        \ACCESS_BUSY[0][17]\, \ACCESS_BUSY[0][18]\, 
        \ACCESS_BUSY[0][19]\, \ACCESS_BUSY[0][20]\, 
        \ACCESS_BUSY[0][21]\, \ACCESS_BUSY[0][22]\, 
        \ACCESS_BUSY[0][23]\, \ACCESS_BUSY[0][24]\, 
        \ACCESS_BUSY[0][25]\, \ACCESS_BUSY[0][26]\, 
        \ACCESS_BUSY[0][27]\, \ACCESS_BUSY[0][28]\, 
        \ACCESS_BUSY[0][29]\, \ACCESS_BUSY[0][30]\, 
        \ACCESS_BUSY[0][31]\, \ACCESS_BUSY[0][32]\, 
        \ACCESS_BUSY[0][33]\, \ACCESS_BUSY[0][34]\, 
        \ACCESS_BUSY[0][35]\, \ACCESS_BUSY[0][36]\, 
        \ACCESS_BUSY[0][37]\, \ACCESS_BUSY[0][38]\, 
        \ACCESS_BUSY[0][39]\, \ACCESS_BUSY[1][0]\, 
        \ACCESS_BUSY[1][1]\, \ACCESS_BUSY[1][2]\, 
        \ACCESS_BUSY[1][3]\, \ACCESS_BUSY[1][4]\, 
        \ACCESS_BUSY[1][5]\, \ACCESS_BUSY[1][6]\, 
        \ACCESS_BUSY[1][7]\, \ACCESS_BUSY[1][8]\, 
        \ACCESS_BUSY[1][9]\, \ACCESS_BUSY[1][10]\, 
        \ACCESS_BUSY[1][11]\, \ACCESS_BUSY[1][12]\, 
        \ACCESS_BUSY[1][13]\, \ACCESS_BUSY[1][14]\, 
        \ACCESS_BUSY[1][15]\, \ACCESS_BUSY[1][16]\, 
        \ACCESS_BUSY[1][17]\, \ACCESS_BUSY[1][18]\, 
        \ACCESS_BUSY[1][19]\, \ACCESS_BUSY[1][20]\, 
        \ACCESS_BUSY[1][21]\, \ACCESS_BUSY[1][22]\, 
        \ACCESS_BUSY[1][23]\, \ACCESS_BUSY[1][24]\, 
        \ACCESS_BUSY[1][25]\, \ACCESS_BUSY[1][26]\, 
        \ACCESS_BUSY[1][27]\, \ACCESS_BUSY[1][28]\, 
        \ACCESS_BUSY[1][29]\, \ACCESS_BUSY[1][30]\, 
        \ACCESS_BUSY[1][31]\, \ACCESS_BUSY[1][32]\, 
        \ACCESS_BUSY[1][33]\, \ACCESS_BUSY[1][34]\, 
        \ACCESS_BUSY[1][35]\, \ACCESS_BUSY[1][36]\, 
        \ACCESS_BUSY[1][37]\, \ACCESS_BUSY[1][38]\, 
        \ACCESS_BUSY[1][39]\, \ACCESS_BUSY[2][0]\, 
        \ACCESS_BUSY[2][1]\, \ACCESS_BUSY[2][2]\, 
        \ACCESS_BUSY[2][3]\, \ACCESS_BUSY[2][4]\, 
        \ACCESS_BUSY[2][5]\, \ACCESS_BUSY[2][6]\, 
        \ACCESS_BUSY[2][7]\, \ACCESS_BUSY[2][8]\, 
        \ACCESS_BUSY[2][9]\, \ACCESS_BUSY[2][10]\, 
        \ACCESS_BUSY[2][11]\, \ACCESS_BUSY[2][12]\, 
        \ACCESS_BUSY[2][13]\, \ACCESS_BUSY[2][14]\, 
        \ACCESS_BUSY[2][15]\, \ACCESS_BUSY[2][16]\, 
        \ACCESS_BUSY[2][17]\, \ACCESS_BUSY[2][18]\, 
        \ACCESS_BUSY[2][19]\, \ACCESS_BUSY[2][20]\, 
        \ACCESS_BUSY[2][21]\, \ACCESS_BUSY[2][22]\, 
        \ACCESS_BUSY[2][23]\, \ACCESS_BUSY[2][24]\, 
        \ACCESS_BUSY[2][25]\, \ACCESS_BUSY[2][26]\, 
        \ACCESS_BUSY[2][27]\, \ACCESS_BUSY[2][28]\, 
        \ACCESS_BUSY[2][29]\, \ACCESS_BUSY[2][30]\, 
        \ACCESS_BUSY[2][31]\, \ACCESS_BUSY[2][32]\, 
        \ACCESS_BUSY[2][33]\, \ACCESS_BUSY[2][34]\, 
        \ACCESS_BUSY[2][35]\, \ACCESS_BUSY[2][36]\, 
        \ACCESS_BUSY[2][37]\, \ACCESS_BUSY[2][38]\, 
        \ACCESS_BUSY[2][39]\, \ACCESS_BUSY[3][0]\, 
        \ACCESS_BUSY[3][1]\, \ACCESS_BUSY[3][2]\, 
        \ACCESS_BUSY[3][3]\, \ACCESS_BUSY[3][4]\, 
        \ACCESS_BUSY[3][5]\, \ACCESS_BUSY[3][6]\, 
        \ACCESS_BUSY[3][7]\, \ACCESS_BUSY[3][8]\, 
        \ACCESS_BUSY[3][9]\, \ACCESS_BUSY[3][10]\, 
        \ACCESS_BUSY[3][11]\, \ACCESS_BUSY[3][12]\, 
        \ACCESS_BUSY[3][13]\, \ACCESS_BUSY[3][14]\, 
        \ACCESS_BUSY[3][15]\, \ACCESS_BUSY[3][16]\, 
        \ACCESS_BUSY[3][17]\, \ACCESS_BUSY[3][18]\, 
        \ACCESS_BUSY[3][19]\, \ACCESS_BUSY[3][20]\, 
        \ACCESS_BUSY[3][21]\, \ACCESS_BUSY[3][22]\, 
        \ACCESS_BUSY[3][23]\, \ACCESS_BUSY[3][24]\, 
        \ACCESS_BUSY[3][25]\, \ACCESS_BUSY[3][26]\, 
        \ACCESS_BUSY[3][27]\, \ACCESS_BUSY[3][28]\, 
        \ACCESS_BUSY[3][29]\, \ACCESS_BUSY[3][30]\, 
        \ACCESS_BUSY[3][31]\, \ACCESS_BUSY[3][32]\, 
        \ACCESS_BUSY[3][33]\, \ACCESS_BUSY[3][34]\, 
        \ACCESS_BUSY[3][35]\, \ACCESS_BUSY[3][36]\, 
        \ACCESS_BUSY[3][37]\, \ACCESS_BUSY[3][38]\, 
        \ACCESS_BUSY[3][39]\, \VCC\, \GND\, ADLIB_VCC
         : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc145, nc901, nc4220, nc3562, nc1327, nc3377, nc4369, 
        nc3329, nc2284, nc2291, nc2487, nc4074, nc12, nc2285, 
        nc5918, nc1685, nc1460, nc820, nc1096, nc1176, nc3085, 
        nc2461, nc5095, nc1872, nc1875, nc421, nc5324, nc1505, 
        nc6213, nc4652, nc3632, nc615, nc2093, nc4028, nc5135, 
        nc113, nc3195, nc3419, nc2652, nc834, nc191, nc1019, 
        nc4941, nc3252, nc60, nc5712, nc3416, nc465, nc363, 
        nc6217, nc1821, nc3871, nc1930, nc5102, nc265, nc1384, 
        nc5142, nc4262, nc3222, nc1435, nc3958, nc1121, nc4799, 
        nc3171, nc5473, nc2897, nc5666, nc807, nc3116, nc5572, 
        nc3741, nc4134, nc1777, nc3812, nc4968, nc3928, nc3815, 
        nc5301, nc1890, nc1431, nc1052, nc244, nc297, nc2079, 
        nc5335, nc772, nc5341, nc3752, nc3395, nc2513, nc4206, 
        nc2721, nc904, nc6178, nc2332, nc5955, nc3464, nc2912, 
        nc477, nc6060, nc2164, nc4036, nc1826, nc3876, nc3408, 
        nc2682, nc4762, nc3722, nc3561, nc5633, nc3182, nc400, 
        nc3693, nc6208, nc4298, nc5192, nc4488, nc5639, nc1403, 
        nc194, nc1049, nc3699, nc268, nc644, nc4714, nc2500, 
        nc1828, nc1502, nc3878, nc2066, nc3717, nc1557, nc2097, 
        nc5216, nc5357, nc1720, nc609, nc3770, nc1514, nc57, 
        nc1379, nc386, nc4310, nc3381, nc5631, nc2137, nc5391, 
        nc3691, nc2400, nc2617, nc2118, nc5520, nc4021, nc1666, 
        nc3306, nc501, nc49, nc6154, nc5209, nc5474, nc1755, 
        nc1134, nc4604, nc4040, nc2042, nc4516, nc5249, nc4386, 
        nc33, nc4830, nc2133, nc2130, nc5571, nc5420, nc2698, 
        nc833, nc5851, nc1580, nc4927, nc3363, nc3256, nc2234, 
        nc2913, nc2437, nc1911, nc2235, nc889, nc6056, nc5568, 
        nc1824, nc139, nc2819, nc3874, nc2574, nc1272, nc891, 
        nc1036, nc2290, nc324, nc5151, nc356, nc5169, nc2860, 
        nc3319, nc4743, nc4266, nc3605, nc3226, nc6042, nc305, 
        nc5781, nc1480, nc4024, nc2547, nc587, nc806, nc5614, 
        nc1978, nc733, nc222, nc4685, nc1924, nc3974, nc1404, 
        nc2098, nc5409, nc406, nc302, nc1650, nc3289, nc1544, 
        nc5449, nc5299, nc4115, nc5406, nc1501, nc739, nc2971, 
        nc765, nc5856, nc5446, nc859, nc3304, nc1772, nc2745, 
        nc3212, nc5373, nc80, nc4472, nc4458, nc3438, nc4384, 
        nc5106, nc641, nc3654, nc5858, nc2458, nc5802, nc1830, 
        nc5805, nc5146, nc4909, nc557, nc1291, nc180, nc6079, 
        nc3918, nc1055, nc697, nc1328, nc1941, nc5842, nc3378, 
        nc905, nc5845, nc1568, nc5750, nc4664, nc3624, nc433, 
        nc2632, nc316, nc1169, nc4315, nc3489, nc1093, nc4545, 
        nc5499, nc2606, nc3486, nc3744, nc263, nc5496, nc3960, 
        nc472, nc3712, nc6189, nc236, nc1303, nc4356, nc3336, 
        nc2640, nc5533, nc3465, nc4613, nc5919, nc3593, nc721, 
        nc1010, nc5932, nc2724, nc2356, nc5707, nc5626, nc4619, 
        nc3340, nc3992, nc932, nc150, nc3186, nc1897, nc5854, 
        nc5747, nc5196, nc291, nc2019, nc819, nc3882, nc3885, 
        nc528, nc5892, nc2488, nc5895, nc724, nc3461, nc926, 
        nc2320, nc1276, nc6012, nc3546, nc2091, nc1223, nc4611, 
        nc3273, nc1713, nc1686, nc517, nc2045, nc868, nc5954, 
        nc4655, nc3635, nc4995, nc4231, nc3959, nc2526, nc107, 
        nc2655, nc1227, nc2070, nc3277, nc1152, nc5970, nc635, 
        nc5637, nc5138, nc133, nc3500, nc3697, nc3198, nc2997, 
        nc4033, nc5475, nc4969, nc3929, nc3787, nc2261, nc4580, 
        nc4443, nc948, nc5797, nc2386, nc6045, nc5309, nc4542, 
        nc4354, nc3334, nc3216, nc1097, nc5349, nc3400, nc2773, 
        nc4397, nc1351, nc1040, nc2094, nc2063, nc5471, nc3145, 
        nc2354, nc5933, nc110, nc5358, nc3993, nc5839, nc4480, 
        nc72, nc4837, nc3899, nc2508, nc1674, nc301, nc3164, 
        nc2125, nc1900, nc2109, nc2685, nc1405, nc5784, nc2514, 
        nc1743, nc5202, nc1515, nc1698, nc5528, nc4891, nc2867, 
        nc5242, nc3066, nc2142, nc1231, nc5129, nc5761, nc3389, 
        nc5380, nc4422, nc1290, nc6101, nc5399, nc4191, nc5908, 
        nc1401, nc3345, nc6053, nc5948, nc686, nc1033, nc3614, 
        nc1588, nc6137, nc2384, nc5586, nc2911, nc2325, nc1098, 
        nc1726, nc3776, nc1189, nc1259, nc5253, nc2341, nc4037, 
        nc3643, nc6142, nc5174, nc4444, nc2575, nc5702, nc279, 
        nc726, nc3649, nc1823, nc3873, nc5742, nc4896, nc4541, 
        nc5257, nc3282, nc6133, nc6130, nc2623, nc5292, nc1837, 
        nc2438, nc4513, nc6234, nc2629, nc2067, nc6235, nc5076, 
        nc1979, nc94, nc4912, nc3860, nc3641, nc656, nc4898, 
        nc3988, nc4550, nc3530, nc1545, nc4778, nc6015, nc5998, 
        nc4638, nc2550, nc1413, nc484, nc4790, nc5185, nc2621, 
        nc1761, nc4302, nc3606, nc1104, nc1512, nc1459, nc4230, 
        nc5039, nc593, nc4450, nc3430, nc6070, nc6, nc3099, nc399, 
        nc1456, nc4686, nc3782, nc2668, nc5792, nc2450, nc2336, 
        nc2249, nc4579, nc797, nc4038, nc1006, nc3919, nc2260, 
        nc4617, nc4118, nc6057, nc4343, nc526, nc1037, nc1156, 
        nc142, nc347, nc805, nc1852, nc5206, nc2473, nc1855, 
        nc5870, nc4894, nc5312, nc454, nc5246, nc2572, nc4107, 
        nc874, nc5385, nc2068, nc1091, nc2580, nc500, nc616, 
        nc4913, nc2010, nc2635, nc4994, nc4819, nc504, nc5756, 
        nc5683, nc1443, nc1638, nc6112, nc4103, nc4100, nc2449, 
        nc6197, nc4976, nc336, nc663, nc1542, nc5689, nc2480, 
        nc6129, nc5853, nc4204, nc4407, nc2446, nc4205, nc3352, 
        nc1997, nc963, nc1414, nc961, nc1230, nc1757, nc5117, 
        nc2713, nc1800, nc2492, nc1511, nc3286, nc2334, nc5296, 
        nc6193, nc6190, nc4362, nc3322, nc5534, nc5681, nc6058, 
        nc3594, nc2146, nc5604, nc1094, nc1022, nc1038, nc3508, 
        nc3072, nc126, nc2842, nc4398, nc2845, nc5644, nc5113, 
        nc5110, nc720, nc839, nc308, nc3109, nc414, nc509, nc66, 
        nc4588, nc5214, nc2701, nc5417, nc5764, nc5215, nc181, 
        nc628, nc3543, nc2474, nc4189, nc3157, nc4940, nc4656, 
        nc3636, nc4031, nc3942, nc537, nc2571, nc6146, nc5931, 
        nc4445, nc5360, nc3991, nc2656, nc4779, nc867, nc3261, 
        nc2523, nc5721, nc4167, nc3127, nc1527, nc1359, nc3577, 
        nc2922, nc3153, nc3150, nc545, nc2061, nc2747, nc1444, 
        nc1313, nc3063, nc5566, nc4937, nc3684, nc3254, nc964, 
        nc4728, nc3457, nc4441, nc3255, nc4602, nc5694, nc2515, 
        nc37, nc1541, nc287, nc4163, nc4160, nc3123, nc3120, 
        nc1781, nc151, nc19, nc6219, nc890, nc873, nc6203, nc6164, 
        nc4293, nc1725, nc4264, nc3775, nc3224, nc4467, nc3427, 
        nc4265, nc3647, nc3225, nc3148, nc460, nc4019, nc130, 
        nc491, nc2967, nc179, nc4034, nc4278, nc1252, nc5909, 
        nc3867, nc6207, nc4297, nc8, nc2627, nc2128, nc4529, 
        nc1764, nc5949, nc184, nc6066, nc5271, nc2686, nc2373, 
        nc5612, nc773, nc669, nc1958, nc2064, nc2530, nc6051, 
        nc3943, nc24, nc1031, nc5165, nc3849, nc257, nc1360, 
        nc1372, nc5073, nc2349, nc779, nc561, nc5052, nc2923, 
        nc220, nc1620, nc3670, nc2829, nc2430, nc48, nc1343, 
        nc4144, nc1752, nc1566, nc4558, nc3538, nc1937, nc5583, 
        nc3652, nc111, nc154, nc4159, nc3139, nc2558, nc3989, 
        nc4926, nc2413, nc1201, nc5982, nc5030, nc5999, nc5877, 
        nc522, nc3090, nc3067, nc2159, nc6116, nc2512, nc4046, 
        nc1910, nc365, nc2242, nc6054, nc4662, nc3622, nc881, 
        nc473, nc5365, nc940, nc1177, nc5557, nc1034, nc3312, 
        nc1003, nc866, nc1025, nc1415, nc3075, nc929, nc4514, 
        nc466, nc362, nc2948, nc128, nc45, nc5733, nc3793, nc5663, 
        nc276, nc217, nc1173, nc1170, nc1165, nc5669, nc3668, 
        nc1411, nc4796, nc5755, nc1274, nc5687, nc5188, nc1477, 
        nc972, nc1275, nc1807, nc86, nc2970, nc4893, nc3260, 
        nc2742, nc6185, nc2588, nc851, nc2475, nc5077, nc4911, 
        nc3117, nc5661, nc4729, nc2189, nc1256, nc2704, nc1492, 
        nc114, nc965, nc4840, nc822, nc3068, nc5983, nc2798, 
        nc687, nc5889, nc3049, nc394, nc1940, nc2471, nc105, 
        nc2300, nc3701, nc2414, nc3113, nc3110, nc1365, nc675, 
        nc5724, nc1445, nc173, nc3214, nc3417, nc3215, nc2511, 
        nc5650, nc4781, nc292, nc2029, nc5678, nc1122, nc41, 
        nc3172, nc2636, nc2506, nc636, nc5535, nc5320, nc1663, 
        nc3595, nc1007, nc4228, nc4408, nc2599, nc1114, nc5270, 
        nc1441, nc1669, nc1784, nc657, nc281, nc5526, nc449, 
        nc640, nc1672, nc1321, nc811, nc3371, nc1654, nc5078, 
        nc1380, nc5055, nc1016, nc2246, nc1661, nc4432, nc167, 
        nc4975, nc1608, nc5418, nc1586, nc2174, nc204, nc622, 
        nc4306, nc2105, nc6212, nc2313, nc1200, nc434, nc2996, 
        nc2462, nc4010, nc251, nc3544, nc3612, nc5302, nc2076, 
        nc5125, nc3061, nc1008, nc791, nc4377, nc5342, nc1144, 
        nc604, nc6063, nc5433, nc2524, nc3493, nc3458, nc361, 
        nc320, nc5532, nc617, nc4605, nc1810, nc5316, nc5089, 
        nc3592, nc598, nc6002, nc4092, nc1229, nc3279, nc794, 
        nc2644, nc4713, nc996, nc428, nc5563, nc2305, nc1185, 
        nc4468, nc3967, nc3428, nc2538, nc1046, nc3941, nc5962, 
        nc4751, nc3731, nc2139, nc1959, nc5152, nc4871, nc2751, 
        nc1432, nc5107, nc2921, nc2603, nc4241, nc5325, nc2799, 
        nc5147, nc4171, nc3064, nc4304, nc3382, nc2609, nc5615, 
        nc5392, nc4597, nc3356, nc5071, nc2870, nc4043, nc211, 
        nc5351, nc5103, nc5100, nc5623, nc1429, nc3479, nc4366, 
        nc3326, nc5143, nc5140, nc1385, nc5204, nc5629, nc5407, 
        nc5667, nc5205, nc5168, nc2601, nc1426, nc3476, nc2910, 
        nc5244, nc5447, nc5245, nc5977, nc4876, nc4795, nc79, 
        nc2415, nc1840, nc5314, nc2298, nc5434, nc1683, nc3655, 
        nc4847, nc3494, nc4515, nc3187, nc1563, nc6067, nc3704, 
        nc5621, nc1126, nc5197, nc3176, nc2781, nc1689, nc6216, 
        nc5531, nc1822, nc1962, nc2949, nc1001, nc5963, nc4878, 
        nc3872, nc3591, nc1825, nc131, nc3875, nc5584, nc5074, 
        nc4784, nc2411, nc5869, nc4665, nc3625, nc3300, nc1798, 
        nc4770, nc3183, nc3180, nc601, nc5193, nc5190, nc1681, 
        nc376, nc4380, nc3284, nc3487, nc6174, nc3354, nc3285, 
        nc1907, nc5294, nc5497, nc583, nc5295, nc5259, nc4925, 
        nc3506, nc389, nc4690, nc425, nc323, nc3040, nc1478, 
        nc5981, nc4586, nc4364, nc3324, nc225, nc237, nc1168, 
        nc1667, nc787, nc1727, nc1599, nc865, nc6125, nc3777, 
        nc796, nc6076, nc4047, nc2020, nc1004, nc5602, nc4874, 
        nc4500, nc5642, nc879, nc6188, nc5333, nc3743, nc3393, 
        nc6068, nc560, nc4327, nc1211, nc6005, nc4095, nc4413, 
        nc564, nc553, nc134, nc1963, nc2114, nc4974, nc4400, 
        nc359, nc1869, nc577, nc4512, nc2723, nc5459, nc3105, 
        nc1376, nc1013, nc3418, nc5456, nc4648, nc4738, nc757, 
        nc4185, nc5510, nc1996, nc2016, nc4240, nc228, nc4821, 
        nc3682, nc1329, nc43, nc3379, nc5692, nc2503, nc2271, 
        nc5156, nc2768, nc748, nc5852, nc5410, nc4121, nc2902, 
        nc1817, nc5855, nc5069, nc4754, nc3734, nc368, nc596, 
        nc4048, nc1675, nc4539, nc4378, nc908, nc569, nc170, 
        nc2073, nc2754, nc3316, nc3305, nc5523, nc3550, nc831, 
        nc4350, nc3330, nc5922, nc3545, nc1241, nc4385, nc2731, 
        nc2569, nc513, nc2350, nc1222, nc3272, nc319, nc5080, 
        nc4826, nc4560, nc3603, nc3520, nc6102, nc4192, nc3462, 
        nc2525, nc3450, nc1043, nc4556, nc3536, nc1374, nc4414, 
        nc3609, nc2877, nc2810, nc1583, nc5930, nc5757, nc4683, 
        nc2607, nc2108, nc717, nc3990, nc1352, nc1799, nc1928, 
        nc1982, nc3978, nc2556, nc1738, nc5435, nc4511, nc6061, 
        nc4689, nc3615, nc4828, nc3495, nc4460, nc3420, nc4936, 
        nc1017, nc5783, nc4391, nc3601, nc4720, nc5627, nc5128, 
        nc4273, nc2784, nc1847, nc18, nc880, nc1722, nc5431, 
        nc2903, nc3772, nc2995, nc4681, nc3491, nc196, nc1069, 
        nc2809, nc2966, nc4606, nc790, nc481, nc725, nc637, 
        nc1539, nc4277, nc3314, nc947, nc2380, nc1298, nc6139, 
        nc1157, nc5472, nc6089, nc4155, nc3135, nc1188, nc1687, 
        nc698, nc5564, nc1618, nc5923, nc2077, nc5829, nc2155, 
        nc6064, nc3443, nc5359, nc4824, nc2586, nc4041, nc1210, 
        nc3542, nc2397, nc4313, nc2342, nc1153, nc1150, nc90, 
        nc15, nc850, nc2423, nc5616, nc4739, nc1254, nc1983, 
        nc1457, nc1255, nc2522, nc1889, nc451, nc5408, nc4924, 
        nc1018, nc5961, nc1047, nc6209, nc4299, nc231, nc223, 
        nc5448, nc4947, nc1936, nc5585, nc2678, nc1402, nc4355, 
        nc3335, nc5134, nc2769, nc5252, nc3194, nc2891, nc2355, 
        nc1570, nc2270, nc1226, nc3276, nc4044, nc3656, nc4653, 
        nc3633, nc2185, nc2147, nc2191, nc5958, nc6073, nc4238, 
        nc5036, nc4659, nc3639, nc1564, nc1648, nc2653, nc3096, 
        nc1470, nc102, nc2078, nc307, nc5306, nc4666, nc3626, 
        nc4328, nc2659, nc676, nc828, nc5346, nc1240, nc3488, 
        nc4776, nc4499, nc4508, nc2143, nc2140, nc5498, nc3444, 
        nc11, nc2268, nc5752, nc810, nc4496, nc4651, nc4109, 
        nc3631, nc2244, nc6147, nc2447, nc2245, nc290, nc2009, 
        nc4873, nc2896, nc3510, nc2211, nc3541, nc411, nc2651, 
        nc1739, nc1048, nc3503, nc2424, nc1961, nc1652, nc2385, 
        nc3902, nc5605, nc6106, nc4910, nc4196, nc4583, nc2521, 
        nc2013, nc2898, nc6143, nc6140, nc5029, nc592, nc6199, 
        nc5483, nc4892, nc3410, nc1624, nc5645, nc6128, nc4895, 
        nc3674, nc165, nc4982, nc2734, nc4415, nc5518, nc5582, 
        nc5830, nc3386, nc2790, nc2683, nc384, nc3890, nc5396, 
        nc5119, nc474, nc1011, nc2689, nc2330, nc999, nc4223, 
        nc5060, nc198, nc1089, nc4411, nc1238, nc282, nc2817, 
        nc5304, nc5344, nc3607, nc3108, nc4227, nc6077, nc2536, 
        nc742, nc2681, nc1917, nc3343, nc3558, nc4797, nc3768, 
        nc4687, nc4188, nc3685, nc447, nc5256, nc5763, nc5695, 
        nc2894, nc3159, nc2642, nc354, nc2071, nc2323, nc4568, 
        nc3528, nc3903, nc1014, nc2504, nc4169, nc3129, nc505, 
        nc892, nc3809, nc264, nc252, nc1676, nc2994, nc1995, 
        nc4983, nc3569, nc4889, nc3384, nc1929, nc5484, nc2977, 
        nc3979, nc5394, nc2017, nc54, nc1041, nc6117, nc5524, 
        nc2135, nc5581, nc4114, nc1060, nc533, nc2901, nc339, 
        nc664, nc5778, nc4399, nc2074, nc781, nc6078, nc6080, 
        nc4553, nc3533, nc6113, nc6110, nc1397, nc1947, nc5654, 
        nc1584, nc737, nc4952, nc3932, nc4072, nc4016, nc3616, 
        nc2553, nc2398, nc6214, nc6215, nc20, nc2618, nc588, 
        nc1763, nc5921, nc5565, nc2952, nc314, nc784, nc986, 
        nc3966, nc4726, nc5579, nc2210, nc5500, nc1044, nc2335, 
        nc171, nc3940, nc212, nc5540, nc6202, nc4823, nc4442, 
        nc4292, nc1891, nc6029, nc3445, nc692, nc1708, nc1981, 
        nc4935, nc751, nc5383, nc4577, nc2920, nc2018, nc5400, 
        nc2633, nc1191, nc4998, nc4657, nc4158, nc3637, nc3138, 
        nc5440, nc5231, nc2425, nc2639, nc3291, nc558, nc2657, 
        nc2158, nc3441, nc754, nc2965, nc956, nc1578, nc900, 
        nc4810, nc2583, nc1458, nc5033, nc2293, nc277, nc1179, 
        nc1509, nc3093, nc3009, nc2982, nc390, nc4775, nc5976, 
        nc4701, nc2421, nc4337, nc4792, nc2631, nc3580, nc623, 
        nc4953, nc3933, nc78, nc5590, nc3769, nc1896, nc4089, 
        nc498, nc4859, nc3839, nc923, nc5959, nc1565, nc2297, 
        nc2953, nc921, nc2859, nc5463, nc2367, nc2000, nc3480, 
        nc174, nc6071, nc5837, nc5562, nc5490, nc3897, nc1898, 
        nc661, nc442, nc3518, nc4831, nc1356, nc711, nc5711, 
        nc1790, nc1935, nc3119, nc2687, nc2188, nc62, nc5020, 
        nc1906, nc4670, nc4131, nc75, nc3268, nc2703, nc518, 
        nc3144, nc714, nc47, nc916, nc2861, nc2448, nc5779, 
        nc5980, nc827, nc2124, nc13, nc2983, nc1080, nc2161, 
        nc786, nc830, nc2011, nc1655, nc6074, nc5723, nc5485, 
        nc2889, nc3046, nc3751, nc1337, nc6206, nc4296, nc431, 
        nc1894, nc4836, nc1412, nc5037, nc871, nc4075, nc924, 
        nc3097, nc3504, nc5606, nc1463, nc2026, nc4761, nc3721, 
        nc5646, nc5481, nc1562, nc4584, nc409, nc600, nc4022, 
        nc2917, nc1783, nc5464, nc4838, nc1994, nc420, nc2866, 
        nc2346, nc2796, nc5278, nc1354, nc1709, nc5561, nc1831, 
        nc4730, nc756, nc2893, nc71, nc5638, nc6151, nc4059, 
        nc3901, nc3039, nc2014, nc495, nc393, nc3698, nc2472, 
        nc2868, nc1322, nc2505, nc1131, nc3372, nc629, nc295, 
        nc2059, nc5230, nc4981, nc968, nc3840, nc3290, nc4527, 
        nc2760, nc2533, nc9, nc2645, nc586, nc521, nc3686, nc4694, 
        nc2932, nc4211, nc5696, nc5525, nc677, nc1398, nc2820, 
        nc1442, nc1208, nc5038, nc4834, nc3098, nc1836, nc4013, 
        nc5184, nc4725, nc4172, nc1127, nc3177, nc1585, nc5363, 
        nc1464, nc6135, nc4934, nc2344, nc2864, nc1838, nc325, 
        nc4748, nc1561, nc716, nc556, nc826, nc5086, nc4704, 
        nc2637, nc298, nc2089, nc2138, nc249, nc5508, nc4817, 
        nc1730, nc1123, nc1120, nc4371, nc6020, nc3173, nc3170, 
        nc271, nc426, nc322, nc5548, nc5109, nc2964, nc1224, 
        nc1427, nc3274, nc1225, nc3477, nc3275, nc5149, nc4300, 
        nc2403, nc1771, nc1293, nc4554, nc3534, nc2502, nc186, 
        nc4620, nc1550, nc4549, nc2933, nc780, nc2554, nc82, 
        nc2839, nc4338, nc4506, nc334, nc4999, nc1297, nc5714, 
        nc5423, nc3000, nc688, nc1834, nc5522, nc1450, nc925, 
        nc5352, nc232, nc4080, nc96, nc5310, nc3588, nc2368, 
        nc1363, nc4951, nc3931, nc5880, nc5598, nc4017, nc3965, 
        nc4025, nc3189, nc3711, nc1483, nc1934, nc2951, nc5199, 
        nc5031, nc516, nc2092, nc3703, nc3091, nc156, nc1582, 
        nc4279, nc5516, nc750, nc3754, nc4946, nc4783, nc5960, 
        nc658, nc844, nc4105, nc2584, nc5465, nc1622, nc5937, 
        nc4764, nc3724, nc3672, nc3350, nc5157, nc2540, nc795, 
        nc4233, nc3997, nc4618, nc3367, nc3241, nc2404, nc2597, 
        nc162, nc367, nc4360, nc3320, nc2501, nc4210, nc1338, 
        nc4237, nc6195, nc5461, nc3556, nc2440, nc2221, nc5034, 
        nc3043, nc5153, nc5150, nc1718, nc2263, nc5975, nc3094, 
        nc127, nc5424, nc4479, nc2981, nc5254, nc5457, nc5115, 
        nc5255, nc4566, nc3526, nc4476, nc4018, nc2023, nc5521, 
        nc1796, nc731, nc3861, nc4305, nc2267, nc2795, nc2412, 
        nc280, nc116, nc4749, nc3505, nc4122, nc1893, nc710, 
        nc2039, nc293, nc3161, nc3847, nc538, nc1484, nc734, 
        nc1519, nc4176, nc936, nc4603, nc4585, nc1960, nc5377, 
        nc618, nc4872, nc1581, nc4875, nc2778, nc4609, nc1465, 
        nc582, nc2827, nc3155, nc1905, nc4050, nc3030, nc1656, 
        nc321, nc2, nc4321, nc2303, nc5315, nc708, nc1233, nc2050, 
        nc3866, nc5164, nc4165, nc3125, nc989, nc4601, nc250, 
        nc1461, nc4248, nc2690, nc188, nc1748, nc1237, nc5871, 
        nc898, nc573, nc5613, nc2579, nc379, nc5323, nc4753, 
        nc3733, nc5619, nc34, nc3868, nc1307, nc1916, nc4777, 
        nc2753, nc5171, nc5066, nc5652, nc3047, nc777, nc1774, 
        nc4736, nc552, nc843, nc3355, nc5281, nc3760, nc73, nc149, 
        nc4833, nc1383, nc565, nc5701, nc2027, nc1549, nc2095, 
        nc5611, nc3403, nc1370, nc5741, nc4365, nc3325, nc959, 
        nc5083, nc3502, nc2766, nc3653, nc882, nc158, nc2080, 
        nc4483, nc4011, nc2646, nc2534, nc1801, nc5876, nc743, 
        nc3659, nc4229, nc4582, nc2863, nc1576, nc3648, nc2976, 
        nc4663, nc3623, nc1101, nc749, nc3714, nc1164, nc3864, 
        nc4669, nc3629, nc210, nc3240, nc5878, nc2628, nc5887, 
        nc4917, nc4379, nc2783, nc3651, nc5860, nc907, nc4392, 
        nc1719, nc1558, nc4555, nc3535, nc6184, nc2900, nc5770, 
        nc3310, nc2931, nc2220, nc6138, nc1946, nc3781, nc26, 
        nc3964, nc1159, nc3048, nc2555, nc1066, nc2405, nc852, 
        nc512, nc5791, nc4661, nc3621, nc1428, nc736, nc1806, 
        nc4014, nc3478, nc1092, nc1736, nc3516, nc4429, nc443, 
        nc5920, nc2028, nc6086, nc1175, nc1833, nc4426, nc919, 
        nc5425, nc2401, nc4272, nc118, nc1808, nc2192, nc825, 
        nc3404, nc2779, nc1218, nc6107, nc5874, nc4197, nc682, 
        nc246, nc1700, nc3501, nc1980, nc4484, nc5432, nc5087, 
        nc4978, nc4126, nc4503, nc3492, nc3368, nc5421, nc1597, 
        nc4822, nc520, nc1485, nc942, nc4825, nc960, nc4902, 
        nc1326, nc4581, nc3376, nc2391, nc524, nc5974, nc6103, 
        nc6100, nc4193, nc4190, nc2585, nc2548, nc1860, nc1749, 
        nc6204, nc4294, nc3115, nc1375, nc4497, nc6205, nc4295, 
        nc2149, nc4772, nc380, nc812, nc1481, nc17, nc4453, 
        nc3433, nc870, nc2278, nc1795, nc536, nc4552, nc3532, 
        nc5688, nc2453, nc1804, nc652, nc488, nc471, nc5513, 
        nc4032, nc2718, nc1673, nc2552, nc1625, nc645, nc5912, 
        nc3675, nc5280, nc2104, nc143, nc1679, nc4727, nc4607, 
        nc4108, nc6149, nc5378, nc328, nc1904, nc3303, nc3041, 
        nc2030, nc1248, nc529, nc2062, nc3263, nc4945, nc3315, 
        nc5088, nc4383, nc5124, nc2006, nc1671, nc350, nc2519, 
        nc2021, nc5458, nc6198, nc4537, nc3553, nc2299, nc3267, 
        nc1324, nc4903, nc3374, nc1690, nc458, nc3952, nc4809, 
        nc3947, nc3613, nc2733, nc5704, nc5617, nc5118, nc5026, 
        nc4563, nc3523, nc3619, nc2483, nc6161, nc1184, nc5744, 
        nc5261, nc6039, nc693, nc2567, nc4962, nc3922, nc2927, 
        nc4692, nc2582, nc4276, nc4347, nc1308, nc993, nc136, 
        nc4735, nc612, nc5300, nc991, nc4329, nc3044, nc730, 
        nc4454, nc3434, nc702, nc6052, nc5340, nc5063, nc1032, 
        nc469, nc660, nc3611, nc1095, nc5913, nc1086, nc5273, 
        nc2454, nc5356, nc638, nc407, nc4551, nc3531, nc5819, 
        nc2024, nc2916, nc5506, nc2765, nc3657, nc3158, nc2499, 
        nc2551, nc2800, nc5546, nc5277, nc2496, nc4841, nc69, 
        nc310, nc3784, nc5867, nc4667, nc4168, nc3627, nc3128, 
        nc5794, nc4222, nc4141, nc485, nc383, nc418, nc5820, 
        nc1537, nc4630, nc3900, nc3953, nc5655, nc2196, nc50, 
        nc285, nc3380, nc2535, nc897, nc3859, nc2892, nc5390, 
        nc3405, nc2895, nc4928, nc4412, nc1203, nc4980, nc4674, 
        nc1751, nc6119, nc1261, nc5081, nc4963, nc3923, nc4485, 
        nc3766, nc5105, nc4869, nc3829, nc2660, nc2484, nc1880, 
        nc3586, nc994, nc374, nc1207, nc5596, nc1735, nc4353, 
        nc3333, nc5145, nc4846, nc1063, nc3863, nc3401, nc1520, 
        nc3570, nc2719, nc2581, nc1915, nc4722, nc2353, nc4035, 
        nc5354, nc455, nc353, nc5987, nc4481, nc272, nc4009, 
        nc490, nc1192, nc6083, nc5067, nc255, nc4848, nc1420, 
        nc1573, nc3470, nc2797, nc1972, nc2065, nc1867, nc4740, 
        nc288, nc6124, nc230, nc5084, nc6099, nc699, nc5738, 
        nc5305, nc3798, nc1391, nc1317, nc5776, nc5345, nc3185, 
        nc2975, nc2218, nc1630, nc5195, nc2741, nc5019, nc591, 
        nc5668, nc2433, nc532, nc6026, nc5873, nc5603, nc2532, 
        nc4979, nc2383, nc5643, nc5609, nc5260, nc3513, nc3104, 
        nc5539, nc5649, nc4844, nc346, nc1178, nc1677, nc3912, 
        nc3599, nc1945, nc1811, nc939, nc258, nc4184, nc6055, 
        nc415, nc313, nc2399, nc138, nc2377, nc4226, nc1035, 
        nc125, nc5068, nc4132, nc215, nc1111, nc5601, nc3059, 
        nc395, nc1067, nc1706, nc3385, nc3006, nc771, nc4944, 
        nc4950, nc3930, nc5641, nc5395, nc896, nc2201, nc1973, 
        nc4504, nc402, nc4455, nc4086, nc3435, nc2950, nc1803, 
        nc6087, nc4498, nc4069, nc3029, nc496, nc392, nc1879, 
        nc1299, nc578, nc849, nc2162, nc2455, nc774, nc3683, 
        nc1347, nc976, nc5550, nc2003, nc5693, nc4331, nc2871, 
        nc3689, nc3617, nc3118, nc5221, nc5936, nc2292, nc1816, 
        nc5699, nc3996, nc3442, nc4451, nc3431, nc832, nc1668, 
        nc785, nc547, nc89, nc2171, nc2451, nc5450, nc5023, 
        nc4901, nc2361, nc2998, nc2434, nc1260, nc4348, nc2422, 
        nc1626, nc5514, nc3062, nc3676, nc3681, nc1818, nc6030, 
        nc5691, nc2807, nc1841, nc995, nc1281, nc218, nc4624, 
        nc3913, nc2531, nc4396, nc3800, nc3819, nc224, nc1710, 
        nc1499, nc1141, nc1068, nc6152, nc2980, nc4880, nc1083, 
        nc2876, nc2792, nc1132, nc1496, nc5827, nc2485, nc1754, 
        nc755, nc140, nc6088, nc5911, nc77, nc3567, nc283, nc3554, 
        nc4239, nc2878, nc624, nc5739, nc1350, nc4695, nc3799, 
        nc1196, nc5061, nc2481, nc1846, nc1892, nc1331, nc4154, 
        nc3134, nc1887, nc768, nc1895, nc4564, nc3524, nc1814, 
        nc2770, nc5072, nc4243, nc2154, nc2007, nc4718, nc1556, 
        nc2269, nc632, nc3765, nc2333, nc1848, nc3951, nc5967, 
        nc4056, nc3036, nc1914, nc4247, nc197, nc1079, nc888, 
        nc4394, nc253, nc5503, nc2056, nc1740, nc5027, nc5238, 
        nc4961, nc4929, nc3921, nc5902, nc5543, nc3298, nc4439, 
        nc5577, nc5482, nc2874, nc5942, nc2744, nc4519, nc1797, 
        nc5064, nc4436, nc330, nc2608, nc1528, nc776, nc715, 
        nc3578, nc1002, nc2296, nc4000, nc2915, nc1129, nc3179, 
        nc438, nc1087, nc5656, nc2200, nc2340, nc2469, nc3660, 
        nc1155, nc2974, nc1239, nc2184, nc209, nc1061, nc4136, 
        nc2466, nc1318, nc5775, nc5628, nc3019, nc391, nc1844, 
        nc4832, nc858, nc4835, nc6221, nc6090, nc4703, nc2546, 
        nc2008, nc5607, nc5220, nc5108, nc4850, nc3830, nc6081, 
        nc3583, nc1507, nc5593, nc5647, nc5148, nc6171, nc5010, 
        nc2317, nc2086, nc3982, nc2850, nc2166, nc967, nc6023, 
        nc5992, nc1967, nc1944, nc4916, nc1688, nc2862, nc4372, 
        nc2865, nc213, nc3065, nc5028, nc621, nc1399, nc1280, 
        nc2378, nc1355, nc5903, nc3201, nc2694, nc2930, nc1574, 
        nc5809, nc1705, nc1439, nc5943, nc1064, nc5713, nc4746, 
        nc4737, nc576, nc5670, nc5849, nc4281, nc2435, nc2811, 
        nc1436, nc3003, nc3050, nc1088, nc1653, nc4843, nc1213, 
        nc2145, nc6084, nc3687, nc3188, nc4590, nc1659, nc2111, 
        nc4083, nc5697, nc5198, nc1348, nc2767, nc6156, nc4177, 
        nc818, nc1292, nc4060, nc3020, nc2431, nc1136, nc646, 
        nc1217, nc2880, nc1971, nc1832, nc1835, nc4505, nc804, 
        nc3748, nc5075, nc4490, nc3753, nc4719, nc3807, nc1651, 
        nc1998, nc5558, nc3514, nc6145, nc3983, nc4173, nc4170, 
        nc1600, nc5993, nc3889, nc5159, nc4887, nc2816, nc2728, 
        nc435, nc333, nc5899, nc2273, nc4763, nc4274, nc3723, 
        nc4477, nc4275, nc4339, nc2345, nc235, nc3162, nc6027, 
        nc2001, nc1792, nc2277, nc3549, nc2818, nc176, nc5515, 
        nc2999, nc770, nc3911, nc1737, nc2643, nc2369, nc4218, 
        nc1243, nc5, nc444, nc1005, nc2710, nc2529, nc5021, 
        nc2649, nc678, nc3361, nc2907, nc895, nc928, nc2134, 
        nc6062, nc3007, nc4232, nc1247, nc4087, nc5009, nc2641, 
        nc590, nc3555, nc1081, nc6220, nc5927, nc2004, nc4403, 
        nc5049, nc4938, nc594, nc5935, nc4251, nc3231, nc2036, 
        nc5172, nc238, nc3995, nc4502, nc3946, nc2262, nc1716, 
        nc2814, nc2251, nc4565, nc3525, nc5462, nc6028, nc4053, 
        nc3033, nc4672, nc3608, nc1813, nc5024, nc2926, nc1339, 
        nc1987, nc683, nc2968, nc1070, nc762, nc2053, nc4732, 
        nc983, nc4688, nc4322, nc1296, nc5371, nc2914, nc981, 
        nc3200, nc1721, nc30, nc5788, nc3771, nc467, nc4042, 
        nc5413, nc5337, nc803, nc4696, nc3397, nc6115, nc3269, 
        nc4280, nc5512, nc1084, nc3089, nc398, nc109, nc4857, 
        nc3837, nc2776, nc2762, nc1102, nc5099, nc599, nc1773, 
        nc3008, nc2857, nc2873, nc2830, nc1232, nc1553, nc68, 
        nc4088, nc5589, nc653, nc2281, nc1952, nc3749, nc703, 
        nc3010, nc270, nc56, nc5831, nc953, nc4547, nc4127, 
        nc3891, nc3453, nc951, nc2318, nc1301, nc1938, nc1746, 
        nc4404, nc3552, nc92, nc709, nc5504, nc2729, nc2083, 
        nc1462, nc887, nc5131, nc3191, nc5544, nc1843, nc141, 
        nc4501, nc4463, nc3469, nc3423, nc572, nc1694, nc5279, 
        nc4562, nc4123, nc4120, nc3713, nc3522, nc735, nc3466, 
        nc4745, nc1732, nc984, nc4236, nc4224, nc4427, nc4225, 
        nc4057, nc3037, nc65, nc3248, nc1158, nc1657, nc979, 
        nc2887, nc2057, nc5986, nc5901, nc5836, nc178, nc6021, 
        nc5414, nc3896, nc3166, nc480, nc403, nc5941, nc1575, 
        nc3862, nc2266, nc2228, nc3865, nc2543, nc857, nc5511, 
        nc247, nc6065, nc122, nc2942, nc3584, nc327, nc613, 
        nc2213, nc5838, nc5594, nc1953, nc4598, nc3898, nc913, 
        nc4658, nc3638, nc1209, nc206, nc5751, nc1859, nc911, 
        nc689, nc5479, nc954, nc233, nc6109, nc4199, nc5730, 
        nc2658, nc4640, nc4303, nc3790, nc3001, nc2217, nc5476, 
        nc4250, nc3230, nc902, nc3454, nc1012, nc581, nc144, 
        nc872, nc2250, nc4081, nc450, nc4915, nc4634, nc6024, 
        nc3551, nc3981, nc3767, nc3515, nc2087, nc5991, nc4464, 
        nc3424, nc1999, nc4058, nc3038, nc61, nc5176, nc5789, 
        nc3907, nc2647, nc2148, nc1236, nc5872, nc5875, nc4622, 
        nc4561, nc3521, nc2058, nc2392, nc4045, nc2664, nc4987, 
        nc659, nc5834, nc5313, nc44, nc838, nc1409, nc3894, nc605, 
        nc1517, nc385, nc2402, nc103, nc817, nc462, nc2072, 
        nc1406, nc3004, nc4317, nc551, nc1473, nc886, nc4478, 
        nc2943, nc2688, nc1572, nc6148, nc5934, nc2849, nc2231, 
        nc6162, nc4084, nc486, nc382, nc3994, nc914, nc1724, 
        nc5422, nc3774, nc841, nc2280, nc5288, nc1106, nc1715, 
        nc5000, nc5777, nc1802, nc3369, nc1042, nc2033, nc1805, 
        nc3353, nc5040, nc2197, nc410, nc1320, nc5768, nc2577, 
        nc88, nc4811, nc3370, nc672, nc2088, nc355, nc1634, 
        nc4363, nc3323, nc1482, nc525, nc6134, nc2716, nc856, 
        nc4939, nc4900, nc3413, nc4111, nc4376, nc5703, nc985, 
        nc1526, nc2193, nc2190, nc3576, nc3512, nc4405, nc195, 
        nc1059, nc5338, nc456, nc352, nc5743, nc2837, nc2813, 
        nc619, nc3398, nc2294, nc2497, nc2295, nc2775, nc1547, 
        nc4142, nc3262, nc5569, nc6036, nc2969, nc1707, nc511, 
        nc1610, nc370, nc4051, nc3080, nc3031, nc4401, nc5090, 
        nc85, nc4816, nc647, nc5379, nc3968, nc2051, nc1474, 
        nc478, nc5910, nc4675, nc1745, nc5415, nc4341, nc1571, 
        nc955, nc22, nc4957, nc3937, nc4818, nc3783, nc1125, 
        nc3175, nc1768, nc5793, nc3945, nc1015, nc3762, nc2957, 
        nc315, nc2670, nc4710, nc5411, nc816, nc2037, nc5966, 
        nc5233, nc3293, nc6118, nc4374, nc5272, nc294, nc2049, 
        nc3950, nc2925, nc1939, nc187, nc5505, nc4054, nc3034, 
        nc416, nc312, nc1309, nc241, nc5754, nc5545, nc3414, 
        nc3455, nc2054, nc5237, nc3297, nc1569, nc5978, nc4960, 
        nc3920, nc2692, nc3511, nc2081, nc1640, nc1554, nc4104, 
        nc3347, nc5350, nc4465, nc3425, nc81, nc6072, nc920, 
        nc2075, nc1325, nc3375, nc2638, nc6049, nc3451, nc694, 
        nc4814, nc269, nc1373, nc4791, nc2327, nc4249, nc2230, 
        nc5772, nc5556, nc915, nc2987, nc4006, nc157, nc1202, 
        nc6194, nc4461, nc3421, nc1623, nc381, nc4428, nc3673, 
        nc4914, nc3585, nc1629, nc3841, nc3679, nc1951, nc1045, 
        nc5769, nc5595, nc5114, nc6166, nc1908, nc2038, nc3266, 
        nc1112, nc1966, nc2084, nc3141, nc6096, nc2821, nc2012, 
        nc475, nc373, nc1392, nc1621, nc3402, nc3671, nc3313, 
        nc5403, nc306, nc275, nc5016, nc2121, nc5502, nc5443, 
        nc4449, nc1702, nc4482, nc2544, nc351, nc4326, nc5542, 
        nc1311, nc633, nc5155, nc4446, nc5985, nc2708, nc4318, 
        nc3154, nc933, nc5268, nc3846, nc931, nc4800, nc5736, 
        nc4570, nc2172, nc3796, nc2517, nc4164, nc3124, nc117, 
        nc5833, nc4146, nc2826, nc864, nc809, nc5728, nc3893, 
        nc5276, nc1197, nc4842, nc3056, nc3848, nc4845, nc2941, 
        nc4470, nc3, nc3664, nc1769, nc1970, nc4625, nc2509, 
        nc5387, nc3483, nc63, nc2371, nc3740, nc429, nc620, 
        nc1142, nc5493, nc1475, nc4066, nc3026, nc2828, nc507, 
        nc3582, nc2715, nc5355, nc278, nc5810, nc6019, nc5592, 
        nc691, nc1193, nc1190, nc1788, nc4332, nc2720, nc1294, 
        nc5529, nc1497, nc1295, nc837, nc6231, nc1471, nc5653, 
        nc4213, nc1219, nc311, nc1050, nc5404, nc1341, nc2031, 
        nc4324, nc1206, nc5881, nc5659, nc4747, nc5444, nc1268, 
        nc2362, nc6033, nc5501, nc934, nc3910, nc3844, nc4217, 
        nc1589, nc6075, nc5541, nc2906, nc5181, nc3850, nc5674, 
        nc3415, nc885, nc100, nc543, nc2937, nc2610, nc5651, 
        nc2824, nc349, nc1753, nc430, nc4137, nc4860, nc3944, 
        nc3820, nc2279, nc5926, nc4452, nc3432, nc580, nc747, 
        nc3411, nc2498, nc3969, nc584, nc2452, nc1419, nc2924, 
        nc1523, nc2034, nc5886, nc3573, nc3484, nc1416, nc2167, 
        nc639, nc4133, nc4130, nc1922, nc5494, nc3972, nc4794, 
        nc4349, nc4234, nc4437, nc3581, nc2015, nc4235, nc1332, 
        nc1986, nc1174, nc855, nc1604, nc5591, nc36, nc1249, 
        nc1692, nc531, nc2040, nc5888, nc5303, nc775, nc4390, 
        nc863, nc1116, nc2163, nc2160, nc5343, nc3348, nc4676, 
        nc2709, nc1812, nc169, nc1815, nc5780, nc550, nc2264, 
        nc2467, nc998, nc2265, nc2396, nc1076, nc2479, nc554, 
        nc5032, nc388, nc4596, nc4201, nc2328, nc3092, nc2476, 
        nc6172, nc2743, nc589, nc6040, nc6037, nc1128, nc1627, 
        nc3677, nc3178, nc1555, nc5979, nc5729, nc4242, nc763, 
        nc6157, nc2482, nc335, nc4716, nc4520, nc1137, nc4003, 
        nc3114, nc836, nc769, nc1449, nc2176, nc4948, nc4813, 
        nc2872, nc436, nc332, nc273, nc2208, nc5884, nc2875, 
        nc3383, nc2695, nc1446, nc1717, nc1789, nc6153, nc6150, 
        nc5393, nc4420, nc1923, nc5537, nc3973, nc5211, nc1133, 
        nc1130, nc3597, nc1829, nc3016, nc6093, nc3879, nc815, 
        nc5965, nc358, nc3708, nc1234, nc1437, nc4807, nc3243, 
        nc1235, nc559, nc4632, nc2112, nc6105, nc5984, nc5228, 
        nc4742, nc4195, nc83, nc1870, nc1146, nc5013, nc1909, 
        nc6230, nc4788, nc1842, nc1845, nc510, nc2223, nc3247, 
        nc463, nc5735, nc2394, nc514, nc3795, nc5553, nc935, 
        nc2662, nc878, nc2777, nc5952, nc5900, nc6038, nc2545, 
        nc3251, nc1288, nc2311, nc3509, nc2227, nc5367, nc5940, 
        nc5405, nc5817, nc266, nc4578, nc14, nc1453, nc840, 
        nc5445, nc4589, nc1319, nc606, nc4261, nc3221, nc3053, 
        nc1552, nc4179, nc5388, nc441, nc962, nc4395, nc3810, 
        nc99, nc1747, nc5401, nc4007, nc4063, nc3023, nc5441, 
        nc318, nc5861, nc5630, nc1965, nc519, nc6010, nc4693, 
        nc3690, nc5657, nc5158, nc3857, nc4699, nc1632, nc5161, 
        nc3980, nc3906, nc4246, nc6097, nc5990, nc1212, nc2379, 
        nc3485, nc665, nc5495, nc4986, nc4867, nc3827, nc163, 
        nc137, nc4608, nc728, nc5017, nc2219, nc404, nc5953, 
        nc4691, nc1918, nc5035, nc192, nc1029, nc1367, nc5859, 
        nc4626, nc3079, nc397, nc4200, nc3095, nc2443, nc2432, 
        nc3746, nc3481, nc5283, nc5866, nc5491, nc2542, nc1349, 
        nc1498, nc4012, nc4758, nc3843, nc3738, nc1454, nc2590, 
        nc2272, nc5104, nc2726, nc1712, nc5287, nc4008, nc6176, 
        nc6031, nc2758, nc5144, nc3362, nc5618, nc1551, nc5868, 
        nc3057, nc2823, nc1861, nc331, nc2978, nc3709, nc5210, 
        nc4644, nc2490, nc5760, nc2419, nc5006, nc4067, nc3027, 
        nc1161, nc6228, nc6098, nc2416, nc1242, nc5046, nc4789, 
        nc4559, nc4517, nc3539, nc1271, nc1396, nc185, nc2559, 
        nc5018, nc6181, nc2772, nc3658, nc1948, nc1073, nc3167, 
        nc2116, nc3184, nc6034, nc2812, nc5194, nc2905, nc2815, 
        nc4715, nc3250, nc5132, nc927, nc1866, nc5864, nc4668, 
        nc3628, nc3208, nc3192, nc5372, nc2788, nc4438, nc2444, 
        nc1524, nc344, nc1353, nc3574, nc1742, nc4288, nc1695, 
        nc4260, nc3220, nc3163, nc3160, nc2541, nc3086, nc5925, 
        nc3211, nc3058, nc1216, nc5096, nc4956, nc3936, nc1868, 
        nc1877, nc4528, nc3264, nc155, nc5964, nc5800, nc3467, 
        nc3265, nc242, nc5331, nc2468, nc2956, nc5840, nc4129, 
        nc3391, nc5059, nc595, nc1760, nc2307, nc4068, nc3028, 
        nc3013, nc2589, nc5786, nc101, nc2717, nc4949, nc1921, 
        nc4001, nc1985, nc3971, nc284, nc5177, nc1394, nc5883, 
        nc4610, nc1302, nc4336, nc4593, nc5327, nc4992, nc2276, 
        nc3817, nc2801, nc673, nc5368, nc6091, nc4907, nc5173, 
        nc5170, nc2366, nc4771, nc1864, nc973, nc3880, nc3042, 
        nc971, nc684, nc2343, nc5274, nc2696, nc207, nc1077, 
        nc5890, nc5477, nc5275, nc2101, nc1387, nc1438, nc5011, 
        nc1614, nc4759, nc3739, nc4015, nc2986, nc29, nc4635, 
        nc5821, nc1246, nc254, nc2759, nc835, nc2022, nc115, 
        nc4004, nc1107, nc5239, nc1964, nc3299, nc2319, nc6108, 
        nc4697, nc4198, nc3662, nc5121, nc741, nc1950, nc104, 
        nc67, nc5917, nc2665, nc530, nc3547, nc2806, nc1455, 
        nc1881, nc1678, nc1103, nc1100, nc366, nc534, nc6094, 
        nc548, nc3051, nc654, nc5554, nc4334, nc744, nc2674, 
        nc1204, nc3017, nc946, nc1407, nc1205, nc4258, nc3238, 
        nc1336, nc1270, nc1181, nc2527, nc5263, nc4993, nc877, 
        nc5014, nc4899, nc2808, nc2258, nc5826, nc1451, nc4061, 
        nc3021, nc990, nc40, nc2212, nc1368, nc3745, nc5439, 
        nc2364, nc5267, nc3957, nc3499, nc2700, nc1078, nc2738, 
        nc974, nc2789, nc1020, nc5436, nc3070, nc869, nc1644, 
        nc3496, nc1590, nc5951, nc5828, nc2918, nc5672, nc2725, 
        nc214, nc3618, nc1886, nc4967, nc3927, nc338, nc1635, 
        nc1919, nc4112, nc470, nc722, nc801, nc539, nc5720, 
        nc3054, nc567, nc5136, nc3210, nc2940, nc1490, nc5201, 
        nc427, nc3196, nc5832, nc2598, nc1723, nc5835, nc3892, 
        nc3773, nc5241, nc2539, nc2445, nc1888, nc3895, nc2712, 
        nc4064, nc3024, nc2804, nc74, nc2199, nc5082, nc681, 
        nc614, nc5003, nc679, nc3640, nc2288, nc4311, nc3018, 
        nc1780, nc5043, nc1334, nc1263, nc3905, nc1602, nc2441, 
        nc1154, nc571, nc2979, nc2620, nc2904, nc5824, nc4985, 
        nc52, nc1267, nc160, nc5807, nc5737, nc5587, nc3797, 
        nc1056, nc4530, nc3281, nc5847, nc3045, nc5924, nc607, 
        nc5291, nc2936, nc651, nc1884, nc1949, nc4721, nc3307, 
        nc5766, nc375, nc3083, nc2025, nc6009, nc4099, nc499, 
        nc690, nc5093, nc4430, nc4387, nc876, nc1071, nc2560, 
        nc6121, nc5863, nc1525, nc746, nc5785, nc3575, nc2308, 
        nc1984, nc6167, nc476, nc372, nc4774, nc4219, nc2216, 
        nc5050, nc4342, nc2460, nc2144, nc3801, nc3887, nc1977, 
        nc5328, nc4370, nc201, nc5897, nc5007, nc6163, nc6160, 
        nc5339, nc87, nc4881, nc3399, nc3101, nc1850, nc5047, 
        nc3468, nc5753, nc1696, nc4402, nc988, nc2739, nc2046, 
        nc4576, nc3011, nc4181, nc1074, nc975, nc1388, nc6144, 
        nc611, nc5680, nc1530, nc3142, nc4419, nc1766, nc4147, 
        nc2203, nc5608, nc4416, nc3806, nc5232, nc3917, nc5648, 
        nc2614, nc546, nc1863, nc3292, nc2122, nc1430, nc6046, 
        nc4955, nc3935, nc5200, nc4886, nc2207, nc1423, nc5412, 
        nc3473, nc3087, nc2955, nc3366, nc5240, nc4594, nc5097, 
        nc4143, nc4140, nc3341, nc5223, nc2238, nc1522, nc5938, 
        nc958, nc4116, nc3808, nc3572, nc5085, nc3998, nc422, 
        nc4812, nc4244, nc4447, nc3014, nc4815, nc4245, nc5478, 
        nc4175, nc5008, nc4888, nc3700, nc2321, nc5227, nc2840, 
        nc5048, nc4780, nc4357, nc3337, nc1283, nc5732, nc5555, 
        nc4636, nc3792, nc3688, nc4991, nc3452, nc2357, nc177, 
        nc3665, nc5698, nc135, nc1287, nc3280, nc666, nc5290, 
        nc4462, nc3422, nc2666, nc4717, nc5376, nc5062, nc1312, 
        nc3804, nc2985, nc1408, nc1598, nc4375, nc146, nc4851, 
        nc3831, nc2791, nc740, nc98, nc1199, nc4884, nc3088, 
        nc3249, nc2851, nc2919, nc5098, nc3364, nc918, nc4151, 
        nc3131, nc648, nc4673, nc3904, nc1424, nc6114, nc3474, 
        nc371, nc2151, nc2229, nc5182, nc4679, nc4642, nc4984, 
        nc1521, nc4724, nc3571, nc2706, nc5675, nc5567, nc2387, 
        nc2372, nc1117, nc1306, nc2803, nc6016, nc1251, nc464, 
        nc5236, nc234, nc4856, nc4320, nc3836, nc1636, nc4671, 
        nc5453, nc3296, nc95, nc4319, nc5726, nc5381, nc5552, 
        nc2856, nc5001, nc3449, nc182, nc1053, nc387, nc5765, 
        nc5041, nc3308, nc1113, nc1110, nc5823, nc503, nc3446, 
        nc4526, nc1342, nc2881, nc309, nc1062, nc5374, nc4858, 
        nc3838, nc1214, nc4538, nc1417, nc1215, nc2429, nc4388, 
        nc2858, nc634, nc1786, nc1605, nc4139, nc4750, nc3730, 
        nc2426, nc2181, nc707, nc2177, nc6000, nc5907, nc4090, 
        nc6082, nc3146, nc5947, nc2750, nc1883, nc6223, nc1857, 
        nc1323, nc4212, nc3842, nc3373, nc3845, nc2568, nc2169, 
        nc2126, nc152, nc229, nc1472, nc1567, nc2173, nc2170, 
        nc357, nc5004, nc6227, nc2822, nc4918, nc3081, nc2825, 
        nc5634, nc4793, nc2241, nc1147, nc5660, nc5044, nc2274, 
        nc5091, nc3694, nc2477, nc2886, nc1304, nc2275, nc240, 
        nc798, nc4125, nc3560, nc5289, nc91, nc4854, nc3834, 
        nc4708, nc3203, nc2043, nc2854, nc5454, nc1765, nc2888, 
        nc1143, nc1140, nc4712, nc3987, nc4283, nc542, nc3747, 
        nc5997, nc3460, nc3207, nc1244, nc5551, nc4954, nc3934, 
        nc2935, nc1447, nc1245, nc2780, nc5065, nc1057, nc1538, 
        nc3412, nc2954, nc1612, nc4287, nc6159, nc2727, nc4509, 
        nc949, nc1139, nc6043, nc3084, nc2847, nc875, nc5718, 
        nc148, nc5094, nc4, nc4325, nc161, nc5489, nc585, nc112, 
        nc5570, nc317, nc5486, nc2337, nc570, nc2002, nc4573, 
        nc1660, nc4623, nc4595, nc1658, nc574, nc2884, nc1920, 
        nc4358, nc3338, nc3970, nc2794, nc4972, nc824, nc631, 
        nc4629, nc2672, nc5939, nc5519, nc5470, nc3999, nc1425, 
        nc3349, nc2358, nc3475, nc1250, nc5186, nc3758, nc5882, 
        nc5353, nc5022, nc997, nc5885, nc4906, nc2390, nc842, 
        nc267, nc2984, nc2329, nc6238, nc4216, nc2831, nc4621, 
        nc4768, nc3728, nc1791, nc2047, nc555, nc4448, nc1421, 
        nc1058, nc3471, nc2507, nc1065, nc1500, nc10, nc1642, 
        nc800, nc2596, nc28, nc2131, nc5162, nc1082, nc401, nc378, 
        nc3559, nc6177, nc4677, nc4178, nc579, nc6085, nc3706, 
        nc3242, nc164, nc2312, nc1400, nc5527, nc5916, nc4786, 
        nc6047, nc3803, nc2705, nc4569, nc3529, nc5787, nc4253, 
        nc3233, nc2222, nc3948, nc2648, nc2388, nc6211, nc5361, 
        nc3666, nc6173, nc6170, nc2253, nc4883, nc2836, nc4346, 
        nc4973, nc4493, nc4257, nc3237, nc2240, nc1587, nc4879, 
        nc46, nc2928, nc4709, nc5725, nc4592, nc25, nc6013, 
        nc2257, nc4614, nc2195, nc980, nc3742, nc2838, nc2117, 
        nc3956, nc642, nc1124, nc2048, nc515, nc3174, nc4731, 
        nc2730, nc2722, nc1785, nc938, nc861, nc6240, nc2600, 
        nc4966, nc3926, nc4645, nc5950, nc1162, nc32, nc2113, 
        nc2110, nc5402, nc5719, nc5389, nc5455, nc1026, nc3076, 
        nc823, nc4208, nc2761, nc2214, nc5676, nc5442, nc2417, 
        nc2215, nc2283, nc6182, nc6048, nc129, nc340, nc5620, 
        nc1051, nc950, nc2395, nc5269, nc1361, nc1778, nc448, 
        nc5451, nc2287, nc2834, nc4344, nc2005, nc723, nc1418, 
        nc21, nc2693, nc1680, nc3759, nc1957, nc4494, nc5282, 
        nc4523, nc2699, nc5218, nc6022, nc729, nc2934, nc4922, 
        nc5025, nc4591, nc3246, nc3568, nc4919, nc1606, nc3482, 
        nc667, nc6017, nc4756, nc3736, nc1579, nc4769, nc3729, 
        nc5492, nc5988, nc3169, nc1731, nc1820, nc2756, nc3870, 
        nc1054, nc792, nc4853, nc3833, nc2226, nc2691, nc5469, 
        nc3718, nc304, nc4079, nc2853, nc497, nc5466, nc2478, 
        nc1085, nc1316, nc489, nc680, nc3002, nc2041, nc3258, 
        nc202, nc5782, nc910, nc2612, nc423, nc1269, nc4082, 
        nc5154, nc2338, nc4627, nc4128, nc5166, nc1794, nc93, 
        nc4268, nc3228, nc261, nc5862, nc3519, nc6210, nc5865, 
        nc1448, nc1976, nc5578, nc2947, nc226, nc2102, nc59, 
        nc4393, nc6041, nc5332, nc3644, nc1390, nc5179, nc5056, 
        nc3392, nc1615, nc3507, nc2376, nc2786, nc922, nc4923, 
        nc6018, nc459, nc650, nc4829, nc4587, nc2624, nc5122, 
        nc2044, nc2883, nc1596, nc4540, nc175, nc2301, nc445, 
        nc343, nc1469, nc245, nc1466, nc5767, nc3705, nc1346, 
        nc132, nc1314, nc3916, nc337, nc1508, nc4440, nc2233, 
        nc1182, nc2675, nc5137, nc4785, nc5321, nc625, nc3197, 
        nc1109, nc6044, nc5286, nc4574, nc123, nc701, nc1779, 
        nc1166, nc4734, nc2237, nc1862, nc5850, nc1865, nc508, 
        nc5133, nc5130, nc704, nc3193, nc3190, nc1381, nc6186, 
        nc1195, nc906, nc1645, nc5234, nc4330, nc5437, nc5235, 
        nc6131, nc3294, nc3497, nc2374, nc3295, nc2764, nc419, 
        nc610, nc3949, nc3600, nc4971, nc6025, nc2593, nc248, 
        nc2209, nc274, nc5369, nc4052, nc3032, nc4905, nc4536, 
        nc4680, nc2992, nc4990, nc2360, nc2929, nc1278, nc2052, 
        nc1221, nc3719, nc3271, nc4495, nc1767, nc1344, nc5708, 
        nc6011, nc5684, nc5229, nc2566, nc1023, nc5748, nc1395, 
        nc3073, nc3005, nc674, nc4491, nc4029, nc492, nc4557, 
        nc4307, nc3537, nc5915, nc4085, nc5262, nc70, nc1734, 
        nc2557, nc1693, nc1289, nc2697, nc2198, nc2409, nc1510, 
        nc5509, nc3218, nc1699, nc4135, nc2406, nc1827, nc5968, 
        nc3877, nc535, nc5549, nc1452, nc1330, nc2736, nc5632, 
        nc3761, nc3692, nc4755, nc3735, nc2082, nc4646, nc6014, 
        nc2418, nc5429, nc4801, nc1369, nc3788, nc2833, nc1410, 
        nc6122, nc4312, nc2755, nc5798, nc5317, nc2993, nc1691, 
        nc2165, nc5426, nc3955, nc2106, nc563, nc1536, nc2899, 
        nc369, nc2802, nc5762, nc2805, nc4101, nc2570, nc745, 
        nc4965, nc3925, nc767, nc1489, nc5126, nc4335, nc4070, 
        nc6104, nc4194, nc5989, nc5906, nc1486, nc2587, nc5822, 
        nc3589, nc5825, nc706, nc5946, nc5599, nc3102, nc6191, 
        nc5811, nc1262, nc23, nc2470, nc3357, nc2316, nc1027, 
        nc4650, nc3630, nc3077, nc4806, nc4117, nc4633, nc4182, 
        nc5771, nc6169, nc5251, nc2365, nc1540, nc5111, nc4524, 
        nc2650, nc6006, nc4096, nc1186, nc6155, nc4639, nc2442, 
        nc2707, nc4773, nc1968, nc1882, nc4367, nc3327, nc1135, 
        nc1, nc1885, nc2785, nc3301, nc788, nc5053, nc4808, 
        nc4113, nc4110, nc2663, nc671, nc1440, nc243, nc4381, 
        nc3851, nc4214, nc2669, nc5727, nc4631, nc4417, nc4700, 
        nc4215, nc1628, nc2615, nc4055, nc3678, nc3035, nc1762, 
        nc3986, nc5816, nc5996, nc4921, nc5266, nc2055, nc3151, 
        nc930, nc1220, nc4861, nc3821, nc3270, nc5709, nc1701, 
        nc326, nc6229, nc4548, nc5857, nc5749, nc2661, nc1787, 
        nc5818, nc4149, nc1335, nc4161, nc3121, nc506, nc2680, 
        nc758, nc4890, nc1028, nc3078, nc2309, nc2314, nc848, 
        nc5710, nc1616, nc4804, nc299, nc2099, nc3856, nc1633, 
        nc4575, nc3209, nc1639, nc829, nc1975, nc5329, nc5208, 
        nc4866, nc3826, nc1593, nc2032, nc4904, nc4289, nc5248, 
        nc3858, nc1992, nc3342, nc3789, nc2085, nc6233, nc5799, 
        nc527, nc5664, nc2202, nc1631, nc5057, nc3750, nc987, 
        nc4612, nc5814, nc4868, nc3828, nc2676, nc1266, nc4152, 
        nc3132, nc2322, nc1389, nc16, nc860, nc6237, nc2152, 
        nc2908, nc1377, nc4760, nc3720, nc461, nc6126, nc5222, 
        nc978, nc2537, nc106, nc5914, nc5438, nc3764, nc718, 
        nc3915, nc3409, nc3498, nc700, nc4308, nc4351, nc3406, 
        nc3331, nc1646, nc3288, nc1198, nc1697, nc3147, nc5658, 
        nc4489, nc5928, nc5298, nc4020, nc608, nc3854, nc3360, 
        nc2702, nc2351, nc120, nc4486, nc439, nc630, nc957, 
        nc1282, nc5250, nc1871, nc2735, nc2127, nc894, nc4473, 
        nc2594, nc3106, nc1758, nc4864, nc3824, nc4533, nc3143, 
        nc3140, nc1021, nc4572, nc3802, nc3566, nc3071, nc3954, 
        nc3805, nc3317, nc1993, nc1171, nc1988, nc5722, nc4932, 
        nc1518, nc3244, nc2510, nc4186, nc3447, nc4723, nc3245, 
        nc1899, nc1664, nc5336, nc5318, nc5058, nc4882, nc3396, 
        nc1119, nc2182, nc4885, nc2123, nc2120, nc4964, nc3924, 
        nc5969, nc2563, nc5774, nc2224, nc2427, nc2225, nc1927, 
        nc3977, nc2962, nc2410, nc1782, nc1559, nc2991, nc4203, 
        nc3811, nc1876, nc5370, nc2381, nc4259, nc3239, nc2630, 
        nc5382, nc2578, nc3707, nc5635, nc3358, nc1024, nc4637, 
        nc4207, nc4138, nc2259, nc6201, nc4291, nc3695, nc3111, 
        nc3074, nc3165, nc2179, nc917, nc5576, nc4787, nc1878, 
        nc2206, nc4368, nc3328, nc2748, nc6003, nc4093, nc1704, 
        nc97, nc1770, nc5213, nc2667, nc2168, nc1548, nc1533, 
        nc4933, nc4474, nc2035, nc200, nc1956, nc4525, nc1932, 
        nc5334, nc5226, nc4839, nc3816, nc1149, nc1300, nc3394, 
        nc3642, nc5217, nc5187, nc4571, nc4459, nc3439, nc1969, 
        nc4897, nc2549, nc4456, nc3436, nc3365, nc2459, nc4741, 
        nc2963, nc502, nc2622, nc364, nc1506, nc3818, nc3309, 
        nc2869, nc39, nc2456, nc1286, nc2289, nc782, nc5175, 
        nc6222, nc3253, nc1874, nc5183, nc5180, nc5051, nc893, 
        nc4389, nc3710, nc262, nc487, nc5284, nc5487, nc3663, 
        nc5285, nc4156, nc3136, nc199, nc1099, nc909, nc172, 
        nc6158, nc5905, nc2604, nc377, nc4852, nc3832, nc108, 
        nc4263, nc3669, nc3257, nc3223, nc1138, nc1637, nc4855, 
        nc3835, nc643, nc5945, nc2156, nc4418, nc1974, nc2852, 
        nc943, nc2855, nc941, nc2090, nc5957, nc793, nc4267, 
        nc3227, nc1759, nc4706, nc3202, nc2616, nc5624, nc2946, 
        nc626, nc4373, nc3661, nc752, nc1105, nc1933, nc58, 
        nc6007, nc5375, nc4803, nc4282, nc4097, nc799, nc3814, 
        nc2489, nc2132, nc5307, nc1839, nc4423, nc5054, nc3908, 
        nc457, nc2486, nc5347, nc2793, nc4522, nc64, nc802, 
        nc4757, nc3737, nc1684, nc4988, nc5673, nc3985, nc4316, 
        nc7, nc1378, nc3914, nc5995, nc2757, nc5716, nc5679, 
        nc2331, nc1258, nc2186, nc3702, nc5530, nc847, nc3590, 
        nc2882, nc4698, nc5801, nc2885, nc5813, nc4039, nc493, 
        nc6032, nc5682, nc761, nc4782, nc5841, nc55, nc1305, 
        nc424, nc6200, nc4290, nc5671, nc2909, nc6179, nc5101, 
        nc5430, nc944, nc1594, nc2749, nc3490, nc3387, nc5141, 
        nc568, nc4615, nc5397, nc764, nc296, nc2069, nc966, 
        nc3756, nc1603, nc1711, nc712, nc3318, nc6008, nc4098, 
        nc440, nc5929, nc1609, nc4359, nc3339, nc992, nc6226, 
        nc417, nc3853, nc575, nc4766, nc3726, nc2787, nc2359, 
        nc1273, nc5806, nc2595, nc4424, nc1991, nc5846, nc4970, 
        nc3881, nc2518, nc5362, nc4863, nc4314, nc3823, nc602, 
        nc738, nc5891, nc1422, nc3472, nc1601, nc649, nc2239, 
        nc1989, nc4521, nc4475, nc2119, nc2248, nc1277, nc3181, 
        nc5808, nc5191, nc2771, nc3206, nc541, nc5848, nc6059, 
        nc695, nc4252, nc3232, nc51, nc193, nc1039, nc5700, 
        nc3448, nc4471, nc4286, nc2252, nc5740, nc76, nc300, 
        nc482, nc4534, nc3563, nc3213, nc4958, nc3938, nc4744, 
        nc27, nc3962, nc2428, nc5167, nc3886, nc1741, nc2958, 
        nc408, nc4002, nc2389, nc5896, nc3217, nc2439, nc345, 
        nc4340, nc2564, nc2436, nc846, nc4752, nc3732, nc5804, 
        nc3888, nc5163, nc5160, nc4323, nc5898, nc1362, nc5844, 
        nc4931, nc2493, nc6165, nc6092, nc3346, nc2752, nc446, 
        nc342, nc5264, nc5467, nc5265, nc4546, nc3780, nc2592, 
        nc121, nc6001, nc5636, nc4091, nc452, nc5790, nc3604, 
        nc3696, nc4507, nc2136, nc5012, nc5904, nc3667, nc3168, 
        nc2326, nc2282, nc2832, nc2835, nc937, nc4684, nc970, 
        nc5944, nc5573, nc2961, nc84, nc4174, nc766, nc5972, 
        nc6035, nc1776, nc2988, nc1090, nc4997, nc4510, nc3645, 
        nc945, nc4705, nc1534, nc1873, nc5452, nc1167, nc3963, 
        nc3884, nc227, nc4076, nc3869, nc5894, nc5517, nc3052, 
        nc2625, nc4410, nc4145, nc6004, nc4094, nc2782, nc6187, 
        nc5308, nc1793, nc2737, nc5348, nc1503, nc1163, nc1160, 
        nc1955, nc5488, nc3984, nc4062, nc3022, nc4256, nc3236, 
        nc5994, nc5677, nc5178, nc3344, nc1902, nc1264, nc1467, 
        nc1265, nc3716, nc124, nc1931, nc6218, nc412, nc2256, 
        nc5715, nc5662, nc6183, nc6180, nc2494, nc3813, nc2324, 
        nc405, nc303, nc3557, nc1714, nc4600, nc3909, nc4920, 
        nc2591, nc205, nc566, nc5973, nc4425, nc4989, nc4345, 
        nc1357, nc5879, nc4567, nc3527, nc4870, nc4030, nc42, 
        nc1310, nc5538, nc6132, nc3598, nc5386, nc3388, nc2302, 
        nc147, nc5398, nc5139, nc1108, nc1607, nc3755, nc3199, 
        nc2339, nc5203, nc4643, nc289, nc4421, nc1516, nc5243, 
        nc4005, nc4649, nc2060, nc5610, nc479, nc670, nc2774, 
        nc4654, nc3634, nc4765, nc3725, nc2945, nc1595, nc5322, 
        nc4733, nc821, nc2286, nc1851, nc5207, nc2654, nc5247, 
        nc2711, nc1903, nc2370, nc5685, nc1809, nc1151, nc4641, 
        nc6095, nc1662, nc2393, nc1728, nc208, nc3778, nc2763, 
        nc2107, nc341, nc1382, nc3069, nc396, nc2232, nc1744, 
        nc5015, nc259, nc2576, nc3650, nc166, nc2347, nc760, 
        nc4616, nc3283, nc5293, nc2938, nc1340, nc1115, nc3540, 
        nc6050, nc5127, nc2103, nc2100, nc1072, nc1856, nc1030, 
        nc5384, nc4660, nc3620, nc668, nc732, nc1529, nc2204, 
        nc3579, nc2407, nc2205, nc4124, nc3287, nc5297, nc2520, 
        nc437, nc1546, nc899, nc3440, nc2684, nc627, nc5123, 
        nc5120, nc6239, nc2732, nc1858, nc3055, nc2841, nc1187, 
        nc884, nc4535, nc4102, nc5224, nc5427, nc5225, nc1733, 
        nc4026, nc1493, nc2420, nc4959, nc3939, nc1750, nc5079, 
        nc597, nc2141, nc1577, nc2175, nc1592, nc4065, nc3025, 
        nc2959, nc1315, nc3012, nc1183, nc1180, nc2565, nc5706, 
        nc53, nc6192, nc1284, nc4301, nc219, nc1487, nc1926, 
        nc1285, nc5746, nc3976, nc5803, nc1613, nc5112, nc1775, 
        nc221, nc1145, nc705, nc6141, nc5843, nc3564, nc2990, 
        nc2846, nc1619, nc854, nc1854, nc4492, nc2495, nc4271, 
        nc190, nc1009, nc3517, nc2375, nc5758, nc2602, nc5468, 
        nc2848, nc4820, nc5311, nc4518, nc1611, nc4073, nc1954, 
        nc2491, nc2989, nc2236, nc6168, nc4119, nc260, nc6136, 
        nc2740, nc3961, nc3786, nc3152, nc2673, nc1535, nc4543, 
        nc4433, nc5796, nc5622, nc5580, nc2679, nc4942, nc3715, 
        nc4532, nc1345, nc845, nc3883, nc1670, nc1494, nc203, 
        nc5893, nc5559, nc1729, nc4162, nc3122, nc3779, nc4209, 
        nc562, nc5574, nc4877, nc1591, nc2463, nc5480, nc3351, 
        nc1682, nc1643, nc5366, nc2671, nc540, nc2562, nc3646, 
        nc3302, nc38, nc814, nc1649, nc544, nc1358, nc2844, nc969, 
        nc5731, nc6127, nc883, nc4382, nc4361, nc3791, nc3321, 
        nc168, nc2714, nc2626, nc1075, nc189, nc4647, nc4148, 
        nc5971, nc5219, nc1468, nc3610, nc1228, nc808, nc3278, 
        nc2634, nc1641, nc2944, nc2310, nc2194, nc5956, nc6123, 
        nc6120, nc1504, nc5665, nc4409, nc783, nc6224, nc6225, 
        nc4406, nc432, nc6111, nc3107, nc4077, nc35, nc1433, 
        nc4943, nc2516, nc348, nc1393, nc4849, nc4434, nc789, 
        nc1532, nc6175, nc2096, nc549, nc853, nc4187, nc862, 
        nc3259, nc3015, nc4531, nc159, nc4106, nc5002, nc1253, 
        nc3103, nc3100, nc4802, nc1366, nc1901, nc5364, nc4805, 
        nc5042, nc5419, nc2348, nc3060, nc778, nc3204, nc2464, 
        nc3407, nc3205, nc4269, nc3229, nc4183, nc4180, nc5416, 
        nc4678, nc753, nc1257, nc2561, nc4284, nc4487, nc4285, 
        nc6196, nc1513, nc483, nc5759, nc4270, nc1172, nc759, 
        nc1912, nc3548, nc2115, nc5507, nc5116, nc3763, nc1665, 
        nc5812, nc4221, nc3149, nc5815, nc5547, nc2939, nc6069, 
        nc696, nc5686, nc523, nc3459, nc2890, nc6232, nc329, 
        nc4707, nc286, nc2528, nc4078, nc31, nc3082, nc3456, 
        nc5092, nc4023, nc1371, nc2129, nc4352, nc4333, nc3332, 
        nc813, nc982, nc727, nc4469, nc3429, nc1434, nc5070, 
        nc5705, nc2573, nc2352, nc119, nc4466, nc3426, nc2243, 
        nc662, nc453, nc5745, nc5258, nc2972, nc2408, nc1531, 
        nc3156, nc1364, nc3112, nc1118, nc1617, nc3852, nc2363, 
        nc1990, nc3855, nc2315, nc2247, nc5717, nc713, nc4827, 
        nc3602, nc1495, nc3587, nc4166, nc3126, nc5773, nc5597, 
        nc256, nc5428, nc4862, nc3822, nc1543, nc4865, nc4798, 
        nc3825, nc977, nc4682, nc4049, nc494, nc685, nc2613, 
        nc719, nc1942, nc4157, nc3137, nc183, nc3311, nc360, 
        nc952, nc1913, nc4309, nc4711, nc2619, nc1819, nc5560, 
        nc3565, nc1000, nc2157, nc1491, nc1756, nc468, nc5600, 
        nc2677, nc2178, nc2306, nc3785, nc1488, nc5795, nc5640, 
        nc1853, nc2382, nc1279, nc3757, nc4153, nc4150, nc3133, 
        nc3130, nc5734, nc5460, nc4599, nc2611, nc3794, nc4254, 
        nc3234, nc4457, nc3437, nc2153, nc2150, nc4255, nc3235, 
        nc239, nc1333, nc1703, nc5326, nc413, nc4767, nc3727, 
        nc2254, nc2457, nc2255, nc655, nc5319, nc5588, nc2973, 
        nc5330, nc4202, nc4027, nc1148, nc1647, nc153, nc3390, 
        nc2879, nc5005, nc4071, nc5189, nc4930, nc2605, nc5045, 
        nc1925, nc3975, nc4435, nc216, nc4908, nc1386, nc5536, 
        nc5575, nc6236, nc3680, nc3596, nc2187, nc3219, nc5690, 
        nc1479, nc912, nc1943, nc5625, nc2960, nc4977, nc1194, 
        nc2746, nc1849, nc4996, nc1560, nc1476, nc4628, nc3359, 
        nc5212, nc4431, nc2465, nc603, nc4544, nc4702, nc3463, 
        nc2304, nc2843, nc2183, nc2180, nc903 : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C14 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%14%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc145, A_DOUT(18) => nc901, 
        A_DOUT(17) => nc4220, A_DOUT(16) => nc3562, A_DOUT(15)
         => nc1327, A_DOUT(14) => nc3377, A_DOUT(13) => nc4369, 
        A_DOUT(12) => nc3329, A_DOUT(11) => nc2284, A_DOUT(10)
         => nc2291, A_DOUT(9) => nc2487, A_DOUT(8) => nc4074, 
        A_DOUT(7) => nc12, A_DOUT(6) => nc2285, A_DOUT(5) => 
        nc5918, A_DOUT(4) => nc1685, A_DOUT(3) => nc1460, 
        A_DOUT(2) => nc820, A_DOUT(1) => nc1096, A_DOUT(0) => 
        \R_DATA_TEMPR2[14]\, B_DOUT(19) => nc1176, B_DOUT(18) => 
        nc3085, B_DOUT(17) => nc2461, B_DOUT(16) => nc5095, 
        B_DOUT(15) => nc1872, B_DOUT(14) => nc1875, B_DOUT(13)
         => nc421, B_DOUT(12) => nc5324, B_DOUT(11) => nc1505, 
        B_DOUT(10) => nc6213, B_DOUT(9) => nc4652, B_DOUT(8) => 
        nc3632, B_DOUT(7) => nc615, B_DOUT(6) => nc2093, 
        B_DOUT(5) => nc4028, B_DOUT(4) => nc5135, B_DOUT(3) => 
        nc113, B_DOUT(2) => nc3195, B_DOUT(1) => nc3419, 
        B_DOUT(0) => nc2652, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][14]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(14), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C36 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%36%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc834, A_DOUT(18) => nc191, 
        A_DOUT(17) => nc1019, A_DOUT(16) => nc4941, A_DOUT(15)
         => nc3252, A_DOUT(14) => nc60, A_DOUT(13) => nc5712, 
        A_DOUT(12) => nc3416, A_DOUT(11) => nc465, A_DOUT(10) => 
        nc363, A_DOUT(9) => nc6217, A_DOUT(8) => nc1821, 
        A_DOUT(7) => nc3871, A_DOUT(6) => nc1930, A_DOUT(5) => 
        nc5102, A_DOUT(4) => nc265, A_DOUT(3) => nc1384, 
        A_DOUT(2) => nc5142, A_DOUT(1) => nc4262, A_DOUT(0) => 
        \R_DATA_TEMPR0[36]\, B_DOUT(19) => nc3222, B_DOUT(18) => 
        nc1435, B_DOUT(17) => nc3958, B_DOUT(16) => nc1121, 
        B_DOUT(15) => nc4799, B_DOUT(14) => nc3171, B_DOUT(13)
         => nc5473, B_DOUT(12) => nc2897, B_DOUT(11) => nc5666, 
        B_DOUT(10) => nc807, B_DOUT(9) => nc3116, B_DOUT(8) => 
        nc5572, B_DOUT(7) => nc3741, B_DOUT(6) => nc4134, 
        B_DOUT(5) => nc1777, B_DOUT(4) => nc3812, B_DOUT(3) => 
        nc4968, B_DOUT(2) => nc3928, B_DOUT(1) => nc3815, 
        B_DOUT(0) => nc5301, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][36]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(36), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C10 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%10%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1890, A_DOUT(18) => nc1431, 
        A_DOUT(17) => nc1052, A_DOUT(16) => nc244, A_DOUT(15) => 
        nc297, A_DOUT(14) => nc2079, A_DOUT(13) => nc5335, 
        A_DOUT(12) => nc772, A_DOUT(11) => nc5341, A_DOUT(10) => 
        nc3752, A_DOUT(9) => nc3395, A_DOUT(8) => nc2513, 
        A_DOUT(7) => nc4206, A_DOUT(6) => nc2721, A_DOUT(5) => 
        nc904, A_DOUT(4) => nc6178, A_DOUT(3) => nc2332, 
        A_DOUT(2) => nc5955, A_DOUT(1) => nc3464, A_DOUT(0) => 
        \R_DATA_TEMPR1[10]\, B_DOUT(19) => nc2912, B_DOUT(18) => 
        nc477, B_DOUT(17) => nc6060, B_DOUT(16) => nc2164, 
        B_DOUT(15) => nc4036, B_DOUT(14) => nc1826, B_DOUT(13)
         => nc3876, B_DOUT(12) => nc3408, B_DOUT(11) => nc2682, 
        B_DOUT(10) => nc4762, B_DOUT(9) => nc3722, B_DOUT(8) => 
        nc3561, B_DOUT(7) => nc5633, B_DOUT(6) => nc3182, 
        B_DOUT(5) => nc400, B_DOUT(4) => nc3693, B_DOUT(3) => 
        nc6208, B_DOUT(2) => nc4298, B_DOUT(1) => nc5192, 
        B_DOUT(0) => nc4488, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][10]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(10), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[37]\ : OR4
      port map(A => \R_DATA_TEMPR0[37]\, B => \R_DATA_TEMPR1[37]\, 
        C => \R_DATA_TEMPR2[37]\, D => \R_DATA_TEMPR3[37]\, Y => 
        R_DATA(37));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C17 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%17%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5639, A_DOUT(18) => nc1403, 
        A_DOUT(17) => nc194, A_DOUT(16) => nc1049, A_DOUT(15) => 
        nc3699, A_DOUT(14) => nc268, A_DOUT(13) => nc644, 
        A_DOUT(12) => nc4714, A_DOUT(11) => nc2500, A_DOUT(10)
         => nc1828, A_DOUT(9) => nc1502, A_DOUT(8) => nc3878, 
        A_DOUT(7) => nc2066, A_DOUT(6) => nc3717, A_DOUT(5) => 
        nc1557, A_DOUT(4) => nc2097, A_DOUT(3) => nc5216, 
        A_DOUT(2) => nc5357, A_DOUT(1) => nc1720, A_DOUT(0) => 
        \R_DATA_TEMPR1[17]\, B_DOUT(19) => nc609, B_DOUT(18) => 
        nc3770, B_DOUT(17) => nc1514, B_DOUT(16) => nc57, 
        B_DOUT(15) => nc1379, B_DOUT(14) => nc386, B_DOUT(13) => 
        nc4310, B_DOUT(12) => nc3381, B_DOUT(11) => nc5631, 
        B_DOUT(10) => nc2137, B_DOUT(9) => nc5391, B_DOUT(8) => 
        nc3691, B_DOUT(7) => nc2400, B_DOUT(6) => nc2617, 
        B_DOUT(5) => nc2118, B_DOUT(4) => nc5520, B_DOUT(3) => 
        nc4021, B_DOUT(2) => nc1666, B_DOUT(1) => nc3306, 
        B_DOUT(0) => nc501, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][17]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(17), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[21]\ : OR4
      port map(A => \R_DATA_TEMPR0[21]\, B => \R_DATA_TEMPR1[21]\, 
        C => \R_DATA_TEMPR2[21]\, D => \R_DATA_TEMPR3[21]\, Y => 
        R_DATA(21));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C23 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%23%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc49, A_DOUT(18) => nc6154, 
        A_DOUT(17) => nc5209, A_DOUT(16) => nc5474, A_DOUT(15)
         => nc1755, A_DOUT(14) => nc1134, A_DOUT(13) => nc4604, 
        A_DOUT(12) => nc4040, A_DOUT(11) => nc2042, A_DOUT(10)
         => nc4516, A_DOUT(9) => nc5249, A_DOUT(8) => nc4386, 
        A_DOUT(7) => nc33, A_DOUT(6) => nc4830, A_DOUT(5) => 
        nc2133, A_DOUT(4) => nc2130, A_DOUT(3) => nc5571, 
        A_DOUT(2) => nc5420, A_DOUT(1) => nc2698, A_DOUT(0) => 
        \R_DATA_TEMPR0[23]\, B_DOUT(19) => nc833, B_DOUT(18) => 
        nc5851, B_DOUT(17) => nc1580, B_DOUT(16) => nc4927, 
        B_DOUT(15) => nc3363, B_DOUT(14) => nc3256, B_DOUT(13)
         => nc2234, B_DOUT(12) => nc2913, B_DOUT(11) => nc2437, 
        B_DOUT(10) => nc1911, B_DOUT(9) => nc2235, B_DOUT(8) => 
        nc889, B_DOUT(7) => nc6056, B_DOUT(6) => nc5568, 
        B_DOUT(5) => nc1824, B_DOUT(4) => nc139, B_DOUT(3) => 
        nc2819, B_DOUT(2) => nc3874, B_DOUT(1) => nc2574, 
        B_DOUT(0) => nc1272, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][23]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(23), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C30 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%30%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc891, A_DOUT(18) => nc1036, 
        A_DOUT(17) => nc2290, A_DOUT(16) => nc324, A_DOUT(15) => 
        nc5151, A_DOUT(14) => nc356, A_DOUT(13) => nc5169, 
        A_DOUT(12) => nc2860, A_DOUT(11) => nc3319, A_DOUT(10)
         => nc4743, A_DOUT(9) => nc4266, A_DOUT(8) => nc3605, 
        A_DOUT(7) => nc3226, A_DOUT(6) => nc6042, A_DOUT(5) => 
        nc305, A_DOUT(4) => nc5781, A_DOUT(3) => nc1480, 
        A_DOUT(2) => nc4024, A_DOUT(1) => nc2547, A_DOUT(0) => 
        \R_DATA_TEMPR2[30]\, B_DOUT(19) => nc587, B_DOUT(18) => 
        nc806, B_DOUT(17) => nc5614, B_DOUT(16) => nc1978, 
        B_DOUT(15) => nc733, B_DOUT(14) => nc222, B_DOUT(13) => 
        nc4685, B_DOUT(12) => nc1924, B_DOUT(11) => nc3974, 
        B_DOUT(10) => nc1404, B_DOUT(9) => nc2098, B_DOUT(8) => 
        nc5409, B_DOUT(7) => nc406, B_DOUT(6) => nc302, B_DOUT(5)
         => nc1650, B_DOUT(4) => nc3289, B_DOUT(3) => nc1544, 
        B_DOUT(2) => nc5449, B_DOUT(1) => nc5299, B_DOUT(0) => 
        nc4115, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][30]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(30), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C31 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%31%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5406, A_DOUT(18) => nc1501, 
        A_DOUT(17) => nc739, A_DOUT(16) => nc2971, A_DOUT(15) => 
        nc765, A_DOUT(14) => nc5856, A_DOUT(13) => nc5446, 
        A_DOUT(12) => nc859, A_DOUT(11) => nc3304, A_DOUT(10) => 
        nc1772, A_DOUT(9) => nc2745, A_DOUT(8) => nc3212, 
        A_DOUT(7) => nc5373, A_DOUT(6) => nc80, A_DOUT(5) => 
        nc4472, A_DOUT(4) => nc4458, A_DOUT(3) => nc3438, 
        A_DOUT(2) => nc4384, A_DOUT(1) => nc5106, A_DOUT(0) => 
        \R_DATA_TEMPR1[31]\, B_DOUT(19) => nc641, B_DOUT(18) => 
        nc3654, B_DOUT(17) => nc5858, B_DOUT(16) => nc2458, 
        B_DOUT(15) => nc5802, B_DOUT(14) => nc1830, B_DOUT(13)
         => nc5805, B_DOUT(12) => nc5146, B_DOUT(11) => nc4909, 
        B_DOUT(10) => nc557, B_DOUT(9) => nc1291, B_DOUT(8) => 
        nc180, B_DOUT(7) => nc6079, B_DOUT(6) => nc3918, 
        B_DOUT(5) => nc1055, B_DOUT(4) => nc697, B_DOUT(3) => 
        nc1328, B_DOUT(2) => nc1941, B_DOUT(1) => nc5842, 
        B_DOUT(0) => nc3378, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][31]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(31), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C37 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%37%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc905, A_DOUT(18) => nc5845, 
        A_DOUT(17) => nc1568, A_DOUT(16) => nc5750, A_DOUT(15)
         => nc4664, A_DOUT(14) => nc3624, A_DOUT(13) => nc433, 
        A_DOUT(12) => nc2632, A_DOUT(11) => nc316, A_DOUT(10) => 
        nc1169, A_DOUT(9) => nc4315, A_DOUT(8) => nc3489, 
        A_DOUT(7) => nc1093, A_DOUT(6) => nc4545, A_DOUT(5) => 
        nc5499, A_DOUT(4) => nc2606, A_DOUT(3) => nc3486, 
        A_DOUT(2) => nc3744, A_DOUT(1) => nc263, A_DOUT(0) => 
        \R_DATA_TEMPR2[37]\, B_DOUT(19) => nc5496, B_DOUT(18) => 
        nc3960, B_DOUT(17) => nc472, B_DOUT(16) => nc3712, 
        B_DOUT(15) => nc6189, B_DOUT(14) => nc236, B_DOUT(13) => 
        nc1303, B_DOUT(12) => nc4356, B_DOUT(11) => nc3336, 
        B_DOUT(10) => nc2640, B_DOUT(9) => nc5533, B_DOUT(8) => 
        nc3465, B_DOUT(7) => nc4613, B_DOUT(6) => nc5919, 
        B_DOUT(5) => nc3593, B_DOUT(4) => nc721, B_DOUT(3) => 
        nc1010, B_DOUT(2) => nc5932, B_DOUT(1) => nc2724, 
        B_DOUT(0) => nc2356, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][37]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(37), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[17]\ : OR4
      port map(A => \R_DATA_TEMPR0[17]\, B => \R_DATA_TEMPR1[17]\, 
        C => \R_DATA_TEMPR2[17]\, D => \R_DATA_TEMPR3[17]\, Y => 
        R_DATA(17));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C38 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%38%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5707, A_DOUT(18) => nc5626, 
        A_DOUT(17) => nc4619, A_DOUT(16) => nc3340, A_DOUT(15)
         => nc3992, A_DOUT(14) => nc932, A_DOUT(13) => nc150, 
        A_DOUT(12) => nc3186, A_DOUT(11) => nc1897, A_DOUT(10)
         => nc5854, A_DOUT(9) => nc5747, A_DOUT(8) => nc5196, 
        A_DOUT(7) => nc291, A_DOUT(6) => nc2019, A_DOUT(5) => 
        nc819, A_DOUT(4) => nc3882, A_DOUT(3) => nc3885, 
        A_DOUT(2) => nc528, A_DOUT(1) => nc5892, A_DOUT(0) => 
        \R_DATA_TEMPR3[38]\, B_DOUT(19) => nc2488, B_DOUT(18) => 
        nc5895, B_DOUT(17) => nc724, B_DOUT(16) => nc3461, 
        B_DOUT(15) => nc926, B_DOUT(14) => nc2320, B_DOUT(13) => 
        nc1276, B_DOUT(12) => nc6012, B_DOUT(11) => nc3546, 
        B_DOUT(10) => nc2091, B_DOUT(9) => nc1223, B_DOUT(8) => 
        nc4611, B_DOUT(7) => nc3273, B_DOUT(6) => nc1713, 
        B_DOUT(5) => nc1686, B_DOUT(4) => nc517, B_DOUT(3) => 
        nc2045, B_DOUT(2) => nc868, B_DOUT(1) => nc5954, 
        B_DOUT(0) => nc4655, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][38]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(38), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[3]\ : OR4
      port map(A => \R_DATA_TEMPR0[3]\, B => \R_DATA_TEMPR1[3]\, 
        C => \R_DATA_TEMPR2[3]\, D => \R_DATA_TEMPR3[3]\, Y => 
        R_DATA(3));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C20 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%20%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3635, A_DOUT(18) => nc4995, 
        A_DOUT(17) => nc4231, A_DOUT(16) => nc3959, A_DOUT(15)
         => nc2526, A_DOUT(14) => nc107, A_DOUT(13) => nc2655, 
        A_DOUT(12) => nc1227, A_DOUT(11) => nc2070, A_DOUT(10)
         => nc3277, A_DOUT(9) => nc1152, A_DOUT(8) => nc5970, 
        A_DOUT(7) => nc635, A_DOUT(6) => nc5637, A_DOUT(5) => 
        nc5138, A_DOUT(4) => nc133, A_DOUT(3) => nc3500, 
        A_DOUT(2) => nc3697, A_DOUT(1) => nc3198, A_DOUT(0) => 
        \R_DATA_TEMPR1[20]\, B_DOUT(19) => nc2997, B_DOUT(18) => 
        nc4033, B_DOUT(17) => nc5475, B_DOUT(16) => nc4969, 
        B_DOUT(15) => nc3929, B_DOUT(14) => nc3787, B_DOUT(13)
         => nc2261, B_DOUT(12) => nc4580, B_DOUT(11) => nc4443, 
        B_DOUT(10) => nc948, B_DOUT(9) => nc5797, B_DOUT(8) => 
        nc2386, B_DOUT(7) => nc6045, B_DOUT(6) => nc5309, 
        B_DOUT(5) => nc4542, B_DOUT(4) => nc4354, B_DOUT(3) => 
        nc3334, B_DOUT(2) => nc3216, B_DOUT(1) => nc1097, 
        B_DOUT(0) => nc5349, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][20]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(20), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C19 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%19%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3400, A_DOUT(18) => nc2773, 
        A_DOUT(17) => nc4397, A_DOUT(16) => nc1351, A_DOUT(15)
         => nc1040, A_DOUT(14) => nc2094, A_DOUT(13) => nc2063, 
        A_DOUT(12) => nc5471, A_DOUT(11) => nc3145, A_DOUT(10)
         => nc2354, A_DOUT(9) => nc5933, A_DOUT(8) => nc110, 
        A_DOUT(7) => nc5358, A_DOUT(6) => nc3993, A_DOUT(5) => 
        nc5839, A_DOUT(4) => nc4480, A_DOUT(3) => nc72, A_DOUT(2)
         => nc4837, A_DOUT(1) => nc3899, A_DOUT(0) => 
        \R_DATA_TEMPR2[19]\, B_DOUT(19) => nc2508, B_DOUT(18) => 
        nc1674, B_DOUT(17) => nc301, B_DOUT(16) => nc3164, 
        B_DOUT(15) => nc2125, B_DOUT(14) => nc1900, B_DOUT(13)
         => nc2109, B_DOUT(12) => nc2685, B_DOUT(11) => nc1405, 
        B_DOUT(10) => nc5784, B_DOUT(9) => nc2514, B_DOUT(8) => 
        nc1743, B_DOUT(7) => nc5202, B_DOUT(6) => nc1515, 
        B_DOUT(5) => nc1698, B_DOUT(4) => nc5528, B_DOUT(3) => 
        nc4891, B_DOUT(2) => nc2867, B_DOUT(1) => nc5242, 
        B_DOUT(0) => nc3066, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][19]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(19), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C27 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%27%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2142, A_DOUT(18) => nc1231, 
        A_DOUT(17) => nc5129, A_DOUT(16) => nc5761, A_DOUT(15)
         => nc3389, A_DOUT(14) => nc5380, A_DOUT(13) => nc4422, 
        A_DOUT(12) => nc1290, A_DOUT(11) => nc6101, A_DOUT(10)
         => nc5399, A_DOUT(9) => nc4191, A_DOUT(8) => nc5908, 
        A_DOUT(7) => nc1401, A_DOUT(6) => nc3345, A_DOUT(5) => 
        nc6053, A_DOUT(4) => nc5948, A_DOUT(3) => nc686, 
        A_DOUT(2) => nc1033, A_DOUT(1) => nc3614, A_DOUT(0) => 
        \R_DATA_TEMPR1[27]\, B_DOUT(19) => nc1588, B_DOUT(18) => 
        nc6137, B_DOUT(17) => nc2384, B_DOUT(16) => nc5586, 
        B_DOUT(15) => nc2911, B_DOUT(14) => nc2325, B_DOUT(13)
         => nc1098, B_DOUT(12) => nc1726, B_DOUT(11) => nc3776, 
        B_DOUT(10) => nc1189, B_DOUT(9) => nc1259, B_DOUT(8) => 
        nc5253, B_DOUT(7) => nc2341, B_DOUT(6) => nc4037, 
        B_DOUT(5) => nc3643, B_DOUT(4) => nc6142, B_DOUT(3) => 
        nc5174, B_DOUT(2) => nc4444, B_DOUT(1) => nc2575, 
        B_DOUT(0) => nc5702, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][27]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(27), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C1 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%1%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc279, A_DOUT(18) => nc726, 
        A_DOUT(17) => nc3649, A_DOUT(16) => nc1823, A_DOUT(15)
         => nc3873, A_DOUT(14) => nc5742, A_DOUT(13) => nc4896, 
        A_DOUT(12) => nc4541, A_DOUT(11) => nc5257, A_DOUT(10)
         => nc3282, A_DOUT(9) => nc6133, A_DOUT(8) => nc6130, 
        A_DOUT(7) => nc2623, A_DOUT(6) => nc5292, A_DOUT(5) => 
        nc1837, A_DOUT(4) => nc2438, A_DOUT(3) => nc4513, 
        A_DOUT(2) => nc6234, A_DOUT(1) => nc2629, A_DOUT(0) => 
        \R_DATA_TEMPR2[1]\, B_DOUT(19) => nc2067, B_DOUT(18) => 
        nc6235, B_DOUT(17) => nc5076, B_DOUT(16) => nc1979, 
        B_DOUT(15) => nc94, B_DOUT(14) => nc4912, B_DOUT(13) => 
        nc3860, B_DOUT(12) => nc3641, B_DOUT(11) => nc656, 
        B_DOUT(10) => nc4898, B_DOUT(9) => nc3988, B_DOUT(8) => 
        nc4550, B_DOUT(7) => nc3530, B_DOUT(6) => nc1545, 
        B_DOUT(5) => nc4778, B_DOUT(4) => nc6015, B_DOUT(3) => 
        nc5998, B_DOUT(2) => nc4638, B_DOUT(1) => nc2550, 
        B_DOUT(0) => nc1413, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][1]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(1), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[30]\ : OR4
      port map(A => \R_DATA_TEMPR0[30]\, B => \R_DATA_TEMPR1[30]\, 
        C => \R_DATA_TEMPR2[30]\, D => \R_DATA_TEMPR3[30]\, Y => 
        R_DATA(30));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C18 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%18%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc484, A_DOUT(18) => nc4790, 
        A_DOUT(17) => nc5185, A_DOUT(16) => nc2621, A_DOUT(15)
         => nc1761, A_DOUT(14) => nc4302, A_DOUT(13) => nc3606, 
        A_DOUT(12) => nc1104, A_DOUT(11) => nc1512, A_DOUT(10)
         => nc1459, A_DOUT(9) => nc4230, A_DOUT(8) => nc5039, 
        A_DOUT(7) => nc593, A_DOUT(6) => nc4450, A_DOUT(5) => 
        nc3430, A_DOUT(4) => nc6070, A_DOUT(3) => nc6, A_DOUT(2)
         => nc3099, A_DOUT(1) => nc399, A_DOUT(0) => 
        \R_DATA_TEMPR3[18]\, B_DOUT(19) => nc1456, B_DOUT(18) => 
        nc4686, B_DOUT(17) => nc3782, B_DOUT(16) => nc2668, 
        B_DOUT(15) => nc5792, B_DOUT(14) => nc2450, B_DOUT(13)
         => nc2336, B_DOUT(12) => nc2249, B_DOUT(11) => nc4579, 
        B_DOUT(10) => nc797, B_DOUT(9) => nc4038, B_DOUT(8) => 
        nc1006, B_DOUT(7) => nc3919, B_DOUT(6) => nc2260, 
        B_DOUT(5) => nc4617, B_DOUT(4) => nc4118, B_DOUT(3) => 
        nc6057, B_DOUT(2) => nc4343, B_DOUT(1) => nc526, 
        B_DOUT(0) => nc1037, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][18]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(18), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[10]\ : OR4
      port map(A => \R_DATA_TEMPR0[10]\, B => \R_DATA_TEMPR1[10]\, 
        C => \R_DATA_TEMPR2[10]\, D => \R_DATA_TEMPR3[10]\, Y => 
        R_DATA(10));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C36 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%36%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1156, A_DOUT(18) => nc142, 
        A_DOUT(17) => nc347, A_DOUT(16) => nc805, A_DOUT(15) => 
        nc1852, A_DOUT(14) => nc5206, A_DOUT(13) => nc2473, 
        A_DOUT(12) => nc1855, A_DOUT(11) => nc5870, A_DOUT(10)
         => nc4894, A_DOUT(9) => nc5312, A_DOUT(8) => nc454, 
        A_DOUT(7) => nc5246, A_DOUT(6) => nc2572, A_DOUT(5) => 
        nc4107, A_DOUT(4) => nc874, A_DOUT(3) => nc5385, 
        A_DOUT(2) => nc2068, A_DOUT(1) => nc1091, A_DOUT(0) => 
        \R_DATA_TEMPR1[36]\, B_DOUT(19) => nc2580, B_DOUT(18) => 
        nc500, B_DOUT(17) => nc616, B_DOUT(16) => nc4913, 
        B_DOUT(15) => nc2010, B_DOUT(14) => nc2635, B_DOUT(13)
         => nc4994, B_DOUT(12) => nc4819, B_DOUT(11) => nc504, 
        B_DOUT(10) => nc5756, B_DOUT(9) => nc5683, B_DOUT(8) => 
        nc1443, B_DOUT(7) => nc1638, B_DOUT(6) => nc6112, 
        B_DOUT(5) => nc4103, B_DOUT(4) => nc4100, B_DOUT(3) => 
        nc2449, B_DOUT(2) => nc6197, B_DOUT(1) => nc4976, 
        B_DOUT(0) => nc336, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][36]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(36), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C4 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%4%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc663, A_DOUT(18) => nc1542, 
        A_DOUT(17) => nc5689, A_DOUT(16) => nc2480, A_DOUT(15)
         => nc6129, A_DOUT(14) => nc5853, A_DOUT(13) => nc4204, 
        A_DOUT(12) => nc4407, A_DOUT(11) => nc2446, A_DOUT(10)
         => nc4205, A_DOUT(9) => nc3352, A_DOUT(8) => nc1997, 
        A_DOUT(7) => nc963, A_DOUT(6) => nc1414, A_DOUT(5) => 
        nc961, A_DOUT(4) => nc1230, A_DOUT(3) => nc1757, 
        A_DOUT(2) => nc5117, A_DOUT(1) => nc2713, A_DOUT(0) => 
        \R_DATA_TEMPR3[4]\, B_DOUT(19) => nc1800, B_DOUT(18) => 
        nc2492, B_DOUT(17) => nc1511, B_DOUT(16) => nc3286, 
        B_DOUT(15) => nc2334, B_DOUT(14) => nc5296, B_DOUT(13)
         => nc6193, B_DOUT(12) => nc6190, B_DOUT(11) => nc4362, 
        B_DOUT(10) => nc3322, B_DOUT(9) => nc5534, B_DOUT(8) => 
        nc5681, B_DOUT(7) => nc6058, B_DOUT(6) => nc3594, 
        B_DOUT(5) => nc2146, B_DOUT(4) => nc5604, B_DOUT(3) => 
        nc1094, B_DOUT(2) => nc1022, B_DOUT(1) => nc1038, 
        B_DOUT(0) => nc3508, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][4]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(4), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C32 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%32%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3072, A_DOUT(18) => nc126, 
        A_DOUT(17) => nc2842, A_DOUT(16) => nc4398, A_DOUT(15)
         => nc2845, A_DOUT(14) => nc5644, A_DOUT(13) => nc5113, 
        A_DOUT(12) => nc5110, A_DOUT(11) => nc720, A_DOUT(10) => 
        nc839, A_DOUT(9) => nc308, A_DOUT(8) => nc3109, A_DOUT(7)
         => nc414, A_DOUT(6) => nc509, A_DOUT(5) => nc66, 
        A_DOUT(4) => nc4588, A_DOUT(3) => nc5214, A_DOUT(2) => 
        nc2701, A_DOUT(1) => nc5417, A_DOUT(0) => 
        \R_DATA_TEMPR3[32]\, B_DOUT(19) => nc5764, B_DOUT(18) => 
        nc5215, B_DOUT(17) => nc181, B_DOUT(16) => nc628, 
        B_DOUT(15) => nc3543, B_DOUT(14) => nc2474, B_DOUT(13)
         => nc4189, B_DOUT(12) => nc3157, B_DOUT(11) => nc4940, 
        B_DOUT(10) => nc4656, B_DOUT(9) => nc3636, B_DOUT(8) => 
        nc4031, B_DOUT(7) => nc3942, B_DOUT(6) => nc537, 
        B_DOUT(5) => nc2571, B_DOUT(4) => nc6146, B_DOUT(3) => 
        nc5931, B_DOUT(2) => nc4445, B_DOUT(1) => nc5360, 
        B_DOUT(0) => nc3991, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][32]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(32), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C5 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%5%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2656, A_DOUT(18) => nc4779, 
        A_DOUT(17) => nc867, A_DOUT(16) => nc3261, A_DOUT(15) => 
        nc2523, A_DOUT(14) => nc5721, A_DOUT(13) => nc4167, 
        A_DOUT(12) => nc3127, A_DOUT(11) => nc1527, A_DOUT(10)
         => nc1359, A_DOUT(9) => nc3577, A_DOUT(8) => nc2922, 
        A_DOUT(7) => nc3153, A_DOUT(6) => nc3150, A_DOUT(5) => 
        nc545, A_DOUT(4) => nc2061, A_DOUT(3) => nc2747, 
        A_DOUT(2) => nc1444, A_DOUT(1) => nc1313, A_DOUT(0) => 
        \R_DATA_TEMPR2[5]\, B_DOUT(19) => nc3063, B_DOUT(18) => 
        nc5566, B_DOUT(17) => nc4937, B_DOUT(16) => nc3684, 
        B_DOUT(15) => nc3254, B_DOUT(14) => nc964, B_DOUT(13) => 
        nc4728, B_DOUT(12) => nc3457, B_DOUT(11) => nc4441, 
        B_DOUT(10) => nc3255, B_DOUT(9) => nc4602, B_DOUT(8) => 
        nc5694, B_DOUT(7) => nc2515, B_DOUT(6) => nc37, B_DOUT(5)
         => nc1541, B_DOUT(4) => nc287, B_DOUT(3) => nc4163, 
        B_DOUT(2) => nc4160, B_DOUT(1) => nc3123, B_DOUT(0) => 
        nc3120, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][5]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(5), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[24]\ : OR4
      port map(A => \R_DATA_TEMPR0[24]\, B => \R_DATA_TEMPR1[24]\, 
        C => \R_DATA_TEMPR2[24]\, D => \R_DATA_TEMPR3[24]\, Y => 
        R_DATA(24));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C21 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%21%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1781, A_DOUT(18) => nc151, 
        A_DOUT(17) => nc19, A_DOUT(16) => nc6219, A_DOUT(15) => 
        nc890, A_DOUT(14) => nc873, A_DOUT(13) => nc6203, 
        A_DOUT(12) => nc6164, A_DOUT(11) => nc4293, A_DOUT(10)
         => nc1725, A_DOUT(9) => nc4264, A_DOUT(8) => nc3775, 
        A_DOUT(7) => nc3224, A_DOUT(6) => nc4467, A_DOUT(5) => 
        nc3427, A_DOUT(4) => nc4265, A_DOUT(3) => nc3647, 
        A_DOUT(2) => nc3225, A_DOUT(1) => nc3148, A_DOUT(0) => 
        \R_DATA_TEMPR3[21]\, B_DOUT(19) => nc460, B_DOUT(18) => 
        nc4019, B_DOUT(17) => nc130, B_DOUT(16) => nc491, 
        B_DOUT(15) => nc2967, B_DOUT(14) => nc179, B_DOUT(13) => 
        nc4034, B_DOUT(12) => nc4278, B_DOUT(11) => nc1252, 
        B_DOUT(10) => nc5909, B_DOUT(9) => nc3867, B_DOUT(8) => 
        nc6207, B_DOUT(7) => nc4297, B_DOUT(6) => nc8, B_DOUT(5)
         => nc2627, B_DOUT(4) => nc2128, B_DOUT(3) => nc4529, 
        B_DOUT(2) => nc1764, B_DOUT(1) => nc5949, B_DOUT(0) => 
        nc184, DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY
         => \ACCESS_BUSY[3][21]\, A_ADDR(13) => R_ADDR(13), 
        A_ADDR(12) => R_ADDR(12), A_ADDR(11) => R_ADDR(11), 
        A_ADDR(10) => R_ADDR(10), A_ADDR(9) => R_ADDR(9), 
        A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), A_ADDR(6)
         => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4) => 
        R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => R_ADDR(2), 
        A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(21), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C35 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%35%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc6066, A_DOUT(18) => nc5271, 
        A_DOUT(17) => nc2686, A_DOUT(16) => nc2373, A_DOUT(15)
         => nc5612, A_DOUT(14) => nc773, A_DOUT(13) => nc669, 
        A_DOUT(12) => nc1958, A_DOUT(11) => nc2064, A_DOUT(10)
         => nc2530, A_DOUT(9) => nc6051, A_DOUT(8) => nc3943, 
        A_DOUT(7) => nc24, A_DOUT(6) => nc1031, A_DOUT(5) => 
        nc5165, A_DOUT(4) => nc3849, A_DOUT(3) => nc257, 
        A_DOUT(2) => nc1360, A_DOUT(1) => nc1372, A_DOUT(0) => 
        \R_DATA_TEMPR3[35]\, B_DOUT(19) => nc5073, B_DOUT(18) => 
        nc2349, B_DOUT(17) => nc779, B_DOUT(16) => nc561, 
        B_DOUT(15) => nc5052, B_DOUT(14) => nc2923, B_DOUT(13)
         => nc220, B_DOUT(12) => nc1620, B_DOUT(11) => nc3670, 
        B_DOUT(10) => nc2829, B_DOUT(9) => nc2430, B_DOUT(8) => 
        nc48, B_DOUT(7) => nc1343, B_DOUT(6) => nc4144, B_DOUT(5)
         => nc1752, B_DOUT(4) => nc1566, B_DOUT(3) => nc4558, 
        B_DOUT(2) => nc3538, B_DOUT(1) => nc1937, B_DOUT(0) => 
        nc5583, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][35]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(35), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C13 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%13%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3652, A_DOUT(18) => nc111, 
        A_DOUT(17) => nc154, A_DOUT(16) => nc4159, A_DOUT(15) => 
        nc3139, A_DOUT(14) => nc2558, A_DOUT(13) => nc3989, 
        A_DOUT(12) => nc4926, A_DOUT(11) => nc2413, A_DOUT(10)
         => nc1201, A_DOUT(9) => nc5982, A_DOUT(8) => nc5030, 
        A_DOUT(7) => nc5999, A_DOUT(6) => nc5877, A_DOUT(5) => 
        nc522, A_DOUT(4) => nc3090, A_DOUT(3) => nc3067, 
        A_DOUT(2) => nc2159, A_DOUT(1) => nc6116, A_DOUT(0) => 
        \R_DATA_TEMPR1[13]\, B_DOUT(19) => nc2512, B_DOUT(18) => 
        nc4046, B_DOUT(17) => nc1910, B_DOUT(16) => nc365, 
        B_DOUT(15) => nc2242, B_DOUT(14) => nc6054, B_DOUT(13)
         => nc4662, B_DOUT(12) => nc3622, B_DOUT(11) => nc881, 
        B_DOUT(10) => nc473, B_DOUT(9) => nc5365, B_DOUT(8) => 
        nc940, B_DOUT(7) => nc1177, B_DOUT(6) => nc5557, 
        B_DOUT(5) => nc1034, B_DOUT(4) => nc3312, B_DOUT(3) => 
        nc1003, B_DOUT(2) => nc866, B_DOUT(1) => nc1025, 
        B_DOUT(0) => nc1415, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][13]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(13), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[23]\ : OR4
      port map(A => \R_DATA_TEMPR0[23]\, B => \R_DATA_TEMPR1[23]\, 
        C => \R_DATA_TEMPR2[23]\, D => \R_DATA_TEMPR3[23]\, Y => 
        R_DATA(23));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C33 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%33%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3075, A_DOUT(18) => nc929, 
        A_DOUT(17) => nc4514, A_DOUT(16) => nc466, A_DOUT(15) => 
        nc362, A_DOUT(14) => nc2948, A_DOUT(13) => nc128, 
        A_DOUT(12) => nc45, A_DOUT(11) => nc5733, A_DOUT(10) => 
        nc3793, A_DOUT(9) => nc5663, A_DOUT(8) => nc276, 
        A_DOUT(7) => nc217, A_DOUT(6) => nc1173, A_DOUT(5) => 
        nc1170, A_DOUT(4) => nc1165, A_DOUT(3) => nc5669, 
        A_DOUT(2) => nc3668, A_DOUT(1) => nc1411, A_DOUT(0) => 
        \R_DATA_TEMPR2[33]\, B_DOUT(19) => nc4796, B_DOUT(18) => 
        nc5755, B_DOUT(17) => nc1274, B_DOUT(16) => nc5687, 
        B_DOUT(15) => nc5188, B_DOUT(14) => nc1477, B_DOUT(13)
         => nc972, B_DOUT(12) => nc1275, B_DOUT(11) => nc1807, 
        B_DOUT(10) => nc86, B_DOUT(9) => nc2970, B_DOUT(8) => 
        nc4893, B_DOUT(7) => nc3260, B_DOUT(6) => nc2742, 
        B_DOUT(5) => nc6185, B_DOUT(4) => nc2588, B_DOUT(3) => 
        nc851, B_DOUT(2) => nc2475, B_DOUT(1) => nc5077, 
        B_DOUT(0) => nc4911, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][33]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(33), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C34 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%34%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3117, A_DOUT(18) => nc5661, 
        A_DOUT(17) => nc4729, A_DOUT(16) => nc2189, A_DOUT(15)
         => nc1256, A_DOUT(14) => nc2704, A_DOUT(13) => nc1492, 
        A_DOUT(12) => nc114, A_DOUT(11) => nc965, A_DOUT(10) => 
        nc4840, A_DOUT(9) => nc822, A_DOUT(8) => nc3068, 
        A_DOUT(7) => nc5983, A_DOUT(6) => nc2798, A_DOUT(5) => 
        nc687, A_DOUT(4) => nc5889, A_DOUT(3) => nc3049, 
        A_DOUT(2) => nc394, A_DOUT(1) => nc1940, A_DOUT(0) => 
        \R_DATA_TEMPR0[34]\, B_DOUT(19) => nc2471, B_DOUT(18) => 
        nc105, B_DOUT(17) => nc2300, B_DOUT(16) => nc3701, 
        B_DOUT(15) => nc2414, B_DOUT(14) => nc3113, B_DOUT(13)
         => nc3110, B_DOUT(12) => nc1365, B_DOUT(11) => nc675, 
        B_DOUT(10) => nc5724, B_DOUT(9) => nc1445, B_DOUT(8) => 
        nc173, B_DOUT(7) => nc3214, B_DOUT(6) => nc3417, 
        B_DOUT(5) => nc3215, B_DOUT(4) => nc2511, B_DOUT(3) => 
        nc5650, B_DOUT(2) => nc4781, B_DOUT(1) => nc292, 
        B_DOUT(0) => nc2029, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][34]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(34), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C0 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5678, A_DOUT(18) => nc1122, 
        A_DOUT(17) => nc41, A_DOUT(16) => nc3172, A_DOUT(15) => 
        nc2636, A_DOUT(14) => nc2506, A_DOUT(13) => nc636, 
        A_DOUT(12) => nc5535, A_DOUT(11) => nc5320, A_DOUT(10)
         => nc1663, A_DOUT(9) => nc3595, A_DOUT(8) => nc1007, 
        A_DOUT(7) => nc4228, A_DOUT(6) => nc4408, A_DOUT(5) => 
        nc2599, A_DOUT(4) => nc1114, A_DOUT(3) => nc5270, 
        A_DOUT(2) => nc1441, A_DOUT(1) => nc1669, A_DOUT(0) => 
        \R_DATA_TEMPR0[0]\, B_DOUT(19) => nc1784, B_DOUT(18) => 
        nc657, B_DOUT(17) => nc281, B_DOUT(16) => nc5526, 
        B_DOUT(15) => nc449, B_DOUT(14) => nc640, B_DOUT(13) => 
        nc1672, B_DOUT(12) => nc1321, B_DOUT(11) => nc811, 
        B_DOUT(10) => nc3371, B_DOUT(9) => nc1654, B_DOUT(8) => 
        nc5078, B_DOUT(7) => nc1380, B_DOUT(6) => nc5055, 
        B_DOUT(5) => nc1016, B_DOUT(4) => nc2246, B_DOUT(3) => 
        nc1661, B_DOUT(2) => nc4432, B_DOUT(1) => nc167, 
        B_DOUT(0) => nc4975, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][0]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(0), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C12 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%12%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1608, A_DOUT(18) => nc5418, 
        A_DOUT(17) => nc1586, A_DOUT(16) => nc2174, A_DOUT(15)
         => nc204, A_DOUT(14) => nc622, A_DOUT(13) => nc4306, 
        A_DOUT(12) => nc2105, A_DOUT(11) => nc6212, A_DOUT(10)
         => nc2313, A_DOUT(9) => nc1200, A_DOUT(8) => nc434, 
        A_DOUT(7) => nc2996, A_DOUT(6) => nc2462, A_DOUT(5) => 
        nc4010, A_DOUT(4) => nc251, A_DOUT(3) => nc3544, 
        A_DOUT(2) => nc3612, A_DOUT(1) => nc5302, A_DOUT(0) => 
        \R_DATA_TEMPR3[12]\, B_DOUT(19) => nc2076, B_DOUT(18) => 
        nc5125, B_DOUT(17) => nc3061, B_DOUT(16) => nc1008, 
        B_DOUT(15) => nc791, B_DOUT(14) => nc4377, B_DOUT(13) => 
        nc5342, B_DOUT(12) => nc1144, B_DOUT(11) => nc604, 
        B_DOUT(10) => nc6063, B_DOUT(9) => nc5433, B_DOUT(8) => 
        nc2524, B_DOUT(7) => nc3493, B_DOUT(6) => nc3458, 
        B_DOUT(5) => nc361, B_DOUT(4) => nc320, B_DOUT(3) => 
        nc5532, B_DOUT(2) => nc617, B_DOUT(1) => nc4605, 
        B_DOUT(0) => nc1810, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][12]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(12), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[25]\ : OR4
      port map(A => \R_DATA_TEMPR0[25]\, B => \R_DATA_TEMPR1[25]\, 
        C => \R_DATA_TEMPR2[25]\, D => \R_DATA_TEMPR3[25]\, Y => 
        R_DATA(25));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C15 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%15%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5316, A_DOUT(18) => nc5089, 
        A_DOUT(17) => nc3592, A_DOUT(16) => nc598, A_DOUT(15) => 
        nc6002, A_DOUT(14) => nc4092, A_DOUT(13) => nc1229, 
        A_DOUT(12) => nc3279, A_DOUT(11) => nc794, A_DOUT(10) => 
        nc2644, A_DOUT(9) => nc4713, A_DOUT(8) => nc996, 
        A_DOUT(7) => nc428, A_DOUT(6) => nc5563, A_DOUT(5) => 
        nc2305, A_DOUT(4) => nc1185, A_DOUT(3) => nc4468, 
        A_DOUT(2) => nc3967, A_DOUT(1) => nc3428, A_DOUT(0) => 
        \R_DATA_TEMPR3[15]\, B_DOUT(19) => nc2538, B_DOUT(18) => 
        nc1046, B_DOUT(17) => nc3941, B_DOUT(16) => nc5962, 
        B_DOUT(15) => nc4751, B_DOUT(14) => nc3731, B_DOUT(13)
         => nc2139, B_DOUT(12) => nc1959, B_DOUT(11) => nc5152, 
        B_DOUT(10) => nc4871, B_DOUT(9) => nc2751, B_DOUT(8) => 
        nc1432, B_DOUT(7) => nc5107, B_DOUT(6) => nc2921, 
        B_DOUT(5) => nc2603, B_DOUT(4) => nc4241, B_DOUT(3) => 
        nc5325, B_DOUT(2) => nc2799, B_DOUT(1) => nc5147, 
        B_DOUT(0) => nc4171, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][15]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(15), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[7]\ : OR4
      port map(A => \R_DATA_TEMPR0[7]\, B => \R_DATA_TEMPR1[7]\, 
        C => \R_DATA_TEMPR2[7]\, D => \R_DATA_TEMPR3[7]\, Y => 
        R_DATA(7));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C23 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%23%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3064, A_DOUT(18) => nc4304, 
        A_DOUT(17) => nc3382, A_DOUT(16) => nc2609, A_DOUT(15)
         => nc5615, A_DOUT(14) => nc5392, A_DOUT(13) => nc4597, 
        A_DOUT(12) => nc3356, A_DOUT(11) => nc5071, A_DOUT(10)
         => nc2870, A_DOUT(9) => nc4043, A_DOUT(8) => nc211, 
        A_DOUT(7) => nc5351, A_DOUT(6) => nc5103, A_DOUT(5) => 
        nc5100, A_DOUT(4) => nc5623, A_DOUT(3) => nc1429, 
        A_DOUT(2) => nc3479, A_DOUT(1) => nc4366, A_DOUT(0) => 
        \R_DATA_TEMPR1[23]\, B_DOUT(19) => nc3326, B_DOUT(18) => 
        nc5143, B_DOUT(17) => nc5140, B_DOUT(16) => nc1385, 
        B_DOUT(15) => nc5204, B_DOUT(14) => nc5629, B_DOUT(13)
         => nc5407, B_DOUT(12) => nc5667, B_DOUT(11) => nc5205, 
        B_DOUT(10) => nc5168, B_DOUT(9) => nc2601, B_DOUT(8) => 
        nc1426, B_DOUT(7) => nc3476, B_DOUT(6) => nc2910, 
        B_DOUT(5) => nc5244, B_DOUT(4) => nc5447, B_DOUT(3) => 
        nc5245, B_DOUT(2) => nc5977, B_DOUT(1) => nc4876, 
        B_DOUT(0) => nc4795, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][23]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(23), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C26 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%26%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc79, A_DOUT(18) => nc2415, 
        A_DOUT(17) => nc1840, A_DOUT(16) => nc5314, A_DOUT(15)
         => nc2298, A_DOUT(14) => nc5434, A_DOUT(13) => nc1683, 
        A_DOUT(12) => nc3655, A_DOUT(11) => nc4847, A_DOUT(10)
         => nc3494, A_DOUT(9) => nc4515, A_DOUT(8) => nc3187, 
        A_DOUT(7) => nc1563, A_DOUT(6) => nc6067, A_DOUT(5) => 
        nc3704, A_DOUT(4) => nc5621, A_DOUT(3) => nc1126, 
        A_DOUT(2) => nc5197, A_DOUT(1) => nc3176, A_DOUT(0) => 
        \R_DATA_TEMPR3[26]\, B_DOUT(19) => nc2781, B_DOUT(18) => 
        nc1689, B_DOUT(17) => nc6216, B_DOUT(16) => nc5531, 
        B_DOUT(15) => nc1822, B_DOUT(14) => nc1962, B_DOUT(13)
         => nc2949, B_DOUT(12) => nc1001, B_DOUT(11) => nc5963, 
        B_DOUT(10) => nc4878, B_DOUT(9) => nc3872, B_DOUT(8) => 
        nc3591, B_DOUT(7) => nc1825, B_DOUT(6) => nc131, 
        B_DOUT(5) => nc3875, B_DOUT(4) => nc5584, B_DOUT(3) => 
        nc5074, B_DOUT(2) => nc4784, B_DOUT(1) => nc2411, 
        B_DOUT(0) => nc5869, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][26]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(26), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C39 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%39%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4665, A_DOUT(18) => nc3625, 
        A_DOUT(17) => nc3300, A_DOUT(16) => nc1798, A_DOUT(15)
         => nc4770, A_DOUT(14) => nc3183, A_DOUT(13) => nc3180, 
        A_DOUT(12) => nc601, A_DOUT(11) => nc5193, A_DOUT(10) => 
        nc5190, A_DOUT(9) => nc1681, A_DOUT(8) => nc376, 
        A_DOUT(7) => nc4380, A_DOUT(6) => nc3284, A_DOUT(5) => 
        nc3487, A_DOUT(4) => nc6174, A_DOUT(3) => nc3354, 
        A_DOUT(2) => nc3285, A_DOUT(1) => nc1907, A_DOUT(0) => 
        \R_DATA_TEMPR0[39]\, B_DOUT(19) => nc5294, B_DOUT(18) => 
        nc5497, B_DOUT(17) => nc583, B_DOUT(16) => nc5295, 
        B_DOUT(15) => nc5259, B_DOUT(14) => nc4925, B_DOUT(13)
         => nc3506, B_DOUT(12) => nc389, B_DOUT(11) => nc4690, 
        B_DOUT(10) => nc425, B_DOUT(9) => nc323, B_DOUT(8) => 
        nc3040, B_DOUT(7) => nc1478, B_DOUT(6) => nc5981, 
        B_DOUT(5) => nc4586, B_DOUT(4) => nc4364, B_DOUT(3) => 
        nc3324, B_DOUT(2) => nc225, B_DOUT(1) => nc237, B_DOUT(0)
         => nc1168, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][39]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(39), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C3 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%3%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1667, A_DOUT(18) => nc787, 
        A_DOUT(17) => nc1727, A_DOUT(16) => nc1599, A_DOUT(15)
         => nc865, A_DOUT(14) => nc6125, A_DOUT(13) => nc3777, 
        A_DOUT(12) => nc796, A_DOUT(11) => nc6076, A_DOUT(10) => 
        nc4047, A_DOUT(9) => nc2020, A_DOUT(8) => nc1004, 
        A_DOUT(7) => nc5602, A_DOUT(6) => nc4874, A_DOUT(5) => 
        nc4500, A_DOUT(4) => nc5642, A_DOUT(3) => nc879, 
        A_DOUT(2) => nc6188, A_DOUT(1) => nc5333, A_DOUT(0) => 
        \R_DATA_TEMPR0[3]\, B_DOUT(19) => nc3743, B_DOUT(18) => 
        nc3393, B_DOUT(17) => nc6068, B_DOUT(16) => nc560, 
        B_DOUT(15) => nc4327, B_DOUT(14) => nc1211, B_DOUT(13)
         => nc6005, B_DOUT(12) => nc4095, B_DOUT(11) => nc4413, 
        B_DOUT(10) => nc564, B_DOUT(9) => nc553, B_DOUT(8) => 
        nc134, B_DOUT(7) => nc1963, B_DOUT(6) => nc2114, 
        B_DOUT(5) => nc4974, B_DOUT(4) => nc4400, B_DOUT(3) => 
        nc359, B_DOUT(2) => nc1869, B_DOUT(1) => nc577, B_DOUT(0)
         => nc4512, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][3]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(3), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C20 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%20%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2723, A_DOUT(18) => nc5459, 
        A_DOUT(17) => nc3105, A_DOUT(16) => nc1376, A_DOUT(15)
         => nc1013, A_DOUT(14) => nc3418, A_DOUT(13) => nc5456, 
        A_DOUT(12) => nc4648, A_DOUT(11) => nc4738, A_DOUT(10)
         => nc757, A_DOUT(9) => nc4185, A_DOUT(8) => nc5510, 
        A_DOUT(7) => nc1996, A_DOUT(6) => nc2016, A_DOUT(5) => 
        nc4240, A_DOUT(4) => nc228, A_DOUT(3) => nc4821, 
        A_DOUT(2) => nc3682, A_DOUT(1) => nc1329, A_DOUT(0) => 
        \R_DATA_TEMPR2[20]\, B_DOUT(19) => nc43, B_DOUT(18) => 
        nc3379, B_DOUT(17) => nc5692, B_DOUT(16) => nc2503, 
        B_DOUT(15) => nc2271, B_DOUT(14) => nc5156, B_DOUT(13)
         => nc2768, B_DOUT(12) => nc748, B_DOUT(11) => nc5852, 
        B_DOUT(10) => nc5410, B_DOUT(9) => nc4121, B_DOUT(8) => 
        nc2902, B_DOUT(7) => nc1817, B_DOUT(6) => nc5855, 
        B_DOUT(5) => nc5069, B_DOUT(4) => nc4754, B_DOUT(3) => 
        nc3734, B_DOUT(2) => nc368, B_DOUT(1) => nc596, B_DOUT(0)
         => nc4048, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][20]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(20), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C27 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%27%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1675, A_DOUT(18) => nc4539, 
        A_DOUT(17) => nc4378, A_DOUT(16) => nc908, A_DOUT(15) => 
        nc569, A_DOUT(14) => nc170, A_DOUT(13) => nc2073, 
        A_DOUT(12) => nc2754, A_DOUT(11) => nc3316, A_DOUT(10)
         => nc3305, A_DOUT(9) => nc5523, A_DOUT(8) => nc3550, 
        A_DOUT(7) => nc831, A_DOUT(6) => nc4350, A_DOUT(5) => 
        nc3330, A_DOUT(4) => nc5922, A_DOUT(3) => nc3545, 
        A_DOUT(2) => nc1241, A_DOUT(1) => nc4385, A_DOUT(0) => 
        \R_DATA_TEMPR2[27]\, B_DOUT(19) => nc2731, B_DOUT(18) => 
        nc2569, B_DOUT(17) => nc513, B_DOUT(16) => nc2350, 
        B_DOUT(15) => nc1222, B_DOUT(14) => nc3272, B_DOUT(13)
         => nc319, B_DOUT(12) => nc5080, B_DOUT(11) => nc4826, 
        B_DOUT(10) => nc4560, B_DOUT(9) => nc3603, B_DOUT(8) => 
        nc3520, B_DOUT(7) => nc6102, B_DOUT(6) => nc4192, 
        B_DOUT(5) => nc3462, B_DOUT(4) => nc2525, B_DOUT(3) => 
        nc3450, B_DOUT(2) => nc1043, B_DOUT(1) => nc4556, 
        B_DOUT(0) => nc3536, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][27]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(27), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[22]\ : OR4
      port map(A => \R_DATA_TEMPR0[22]\, B => \R_DATA_TEMPR1[22]\, 
        C => \R_DATA_TEMPR2[22]\, D => \R_DATA_TEMPR3[22]\, Y => 
        R_DATA(22));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C34 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%34%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1374, A_DOUT(18) => nc4414, 
        A_DOUT(17) => nc3609, A_DOUT(16) => nc2877, A_DOUT(15)
         => nc2810, A_DOUT(14) => nc1583, A_DOUT(13) => nc5930, 
        A_DOUT(12) => nc5757, A_DOUT(11) => nc4683, A_DOUT(10)
         => nc2607, A_DOUT(9) => nc2108, A_DOUT(8) => nc717, 
        A_DOUT(7) => nc3990, A_DOUT(6) => nc1352, A_DOUT(5) => 
        nc1799, A_DOUT(4) => nc1928, A_DOUT(3) => nc1982, 
        A_DOUT(2) => nc3978, A_DOUT(1) => nc2556, A_DOUT(0) => 
        \R_DATA_TEMPR1[34]\, B_DOUT(19) => nc1738, B_DOUT(18) => 
        nc5435, B_DOUT(17) => nc4511, B_DOUT(16) => nc6061, 
        B_DOUT(15) => nc4689, B_DOUT(14) => nc3615, B_DOUT(13)
         => nc4828, B_DOUT(12) => nc3495, B_DOUT(11) => nc4460, 
        B_DOUT(10) => nc3420, B_DOUT(9) => nc4936, B_DOUT(8) => 
        nc1017, B_DOUT(7) => nc5783, B_DOUT(6) => nc4391, 
        B_DOUT(5) => nc3601, B_DOUT(4) => nc4720, B_DOUT(3) => 
        nc5627, B_DOUT(2) => nc5128, B_DOUT(1) => nc4273, 
        B_DOUT(0) => nc2784, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][34]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(34), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C6 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%6%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1847, A_DOUT(18) => nc18, 
        A_DOUT(17) => nc880, A_DOUT(16) => nc1722, A_DOUT(15) => 
        nc5431, A_DOUT(14) => nc2903, A_DOUT(13) => nc3772, 
        A_DOUT(12) => nc2995, A_DOUT(11) => nc4681, A_DOUT(10)
         => nc3491, A_DOUT(9) => nc196, A_DOUT(8) => nc1069, 
        A_DOUT(7) => nc2809, A_DOUT(6) => nc2966, A_DOUT(5) => 
        nc4606, A_DOUT(4) => nc790, A_DOUT(3) => nc481, A_DOUT(2)
         => nc725, A_DOUT(1) => nc637, A_DOUT(0) => 
        \R_DATA_TEMPR3[6]\, B_DOUT(19) => nc1539, B_DOUT(18) => 
        nc4277, B_DOUT(17) => nc3314, B_DOUT(16) => nc947, 
        B_DOUT(15) => nc2380, B_DOUT(14) => nc1298, B_DOUT(13)
         => nc6139, B_DOUT(12) => nc1157, B_DOUT(11) => nc5472, 
        B_DOUT(10) => nc6089, B_DOUT(9) => nc4155, B_DOUT(8) => 
        nc3135, B_DOUT(7) => nc1188, B_DOUT(6) => nc1687, 
        B_DOUT(5) => nc698, B_DOUT(4) => nc5564, B_DOUT(3) => 
        nc1618, B_DOUT(2) => nc5923, B_DOUT(1) => nc2077, 
        B_DOUT(0) => nc5829, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][6]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(6), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C17 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%17%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2155, A_DOUT(18) => nc6064, 
        A_DOUT(17) => nc3443, A_DOUT(16) => nc5359, A_DOUT(15)
         => nc4824, A_DOUT(14) => nc2586, A_DOUT(13) => nc4041, 
        A_DOUT(12) => nc1210, A_DOUT(11) => nc3542, A_DOUT(10)
         => nc2397, A_DOUT(9) => nc4313, A_DOUT(8) => nc2342, 
        A_DOUT(7) => nc1153, A_DOUT(6) => nc1150, A_DOUT(5) => 
        nc90, A_DOUT(4) => nc15, A_DOUT(3) => nc850, A_DOUT(2)
         => nc2423, A_DOUT(1) => nc5616, A_DOUT(0) => 
        \R_DATA_TEMPR0[17]\, B_DOUT(19) => nc4739, B_DOUT(18) => 
        nc1254, B_DOUT(17) => nc1983, B_DOUT(16) => nc1457, 
        B_DOUT(15) => nc1255, B_DOUT(14) => nc2522, B_DOUT(13)
         => nc1889, B_DOUT(12) => nc451, B_DOUT(11) => nc5408, 
        B_DOUT(10) => nc4924, B_DOUT(9) => nc1018, B_DOUT(8) => 
        nc5961, B_DOUT(7) => nc1047, B_DOUT(6) => nc6209, 
        B_DOUT(5) => nc4299, B_DOUT(4) => nc231, B_DOUT(3) => 
        nc223, B_DOUT(2) => nc5448, B_DOUT(1) => nc4947, 
        B_DOUT(0) => nc1936, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][17]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(17), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C10 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%10%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5585, A_DOUT(18) => nc2678, 
        A_DOUT(17) => nc1402, A_DOUT(16) => nc4355, A_DOUT(15)
         => nc3335, A_DOUT(14) => nc5134, A_DOUT(13) => nc2769, 
        A_DOUT(12) => nc5252, A_DOUT(11) => nc3194, A_DOUT(10)
         => nc2891, A_DOUT(9) => nc2355, A_DOUT(8) => nc1570, 
        A_DOUT(7) => nc2270, A_DOUT(6) => nc1226, A_DOUT(5) => 
        nc3276, A_DOUT(4) => nc4044, A_DOUT(3) => nc3656, 
        A_DOUT(2) => nc4653, A_DOUT(1) => nc3633, A_DOUT(0) => 
        \R_DATA_TEMPR0[10]\, B_DOUT(19) => nc2185, B_DOUT(18) => 
        nc2147, B_DOUT(17) => nc2191, B_DOUT(16) => nc5958, 
        B_DOUT(15) => nc6073, B_DOUT(14) => nc4238, B_DOUT(13)
         => nc5036, B_DOUT(12) => nc4659, B_DOUT(11) => nc3639, 
        B_DOUT(10) => nc1564, B_DOUT(9) => nc1648, B_DOUT(8) => 
        nc2653, B_DOUT(7) => nc3096, B_DOUT(6) => nc1470, 
        B_DOUT(5) => nc102, B_DOUT(4) => nc2078, B_DOUT(3) => 
        nc307, B_DOUT(2) => nc5306, B_DOUT(1) => nc4666, 
        B_DOUT(0) => nc3626, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][10]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(10), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C4 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%4%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4328, A_DOUT(18) => nc2659, 
        A_DOUT(17) => nc676, A_DOUT(16) => nc828, A_DOUT(15) => 
        nc5346, A_DOUT(14) => nc1240, A_DOUT(13) => nc3488, 
        A_DOUT(12) => nc4776, A_DOUT(11) => nc4499, A_DOUT(10)
         => nc4508, A_DOUT(9) => nc2143, A_DOUT(8) => nc2140, 
        A_DOUT(7) => nc5498, A_DOUT(6) => nc3444, A_DOUT(5) => 
        nc11, A_DOUT(4) => nc2268, A_DOUT(3) => nc5752, A_DOUT(2)
         => nc810, A_DOUT(1) => nc4496, A_DOUT(0) => 
        \R_DATA_TEMPR2[4]\, B_DOUT(19) => nc4651, B_DOUT(18) => 
        nc4109, B_DOUT(17) => nc3631, B_DOUT(16) => nc2244, 
        B_DOUT(15) => nc6147, B_DOUT(14) => nc2447, B_DOUT(13)
         => nc2245, B_DOUT(12) => nc290, B_DOUT(11) => nc2009, 
        B_DOUT(10) => nc4873, B_DOUT(9) => nc2896, B_DOUT(8) => 
        nc3510, B_DOUT(7) => nc2211, B_DOUT(6) => nc3541, 
        B_DOUT(5) => nc411, B_DOUT(4) => nc2651, B_DOUT(3) => 
        nc1739, B_DOUT(2) => nc1048, B_DOUT(1) => nc3503, 
        B_DOUT(0) => nc2424, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][4]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(4), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C39 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%39%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1961, A_DOUT(18) => nc1652, 
        A_DOUT(17) => nc2385, A_DOUT(16) => nc3902, A_DOUT(15)
         => nc5605, A_DOUT(14) => nc6106, A_DOUT(13) => nc4910, 
        A_DOUT(12) => nc4196, A_DOUT(11) => nc4583, A_DOUT(10)
         => nc2521, A_DOUT(9) => nc2013, A_DOUT(8) => nc2898, 
        A_DOUT(7) => nc6143, A_DOUT(6) => nc6140, A_DOUT(5) => 
        nc5029, A_DOUT(4) => nc592, A_DOUT(3) => nc6199, 
        A_DOUT(2) => nc5483, A_DOUT(1) => nc4892, A_DOUT(0) => 
        \R_DATA_TEMPR1[39]\, B_DOUT(19) => nc3410, B_DOUT(18) => 
        nc1624, B_DOUT(17) => nc5645, B_DOUT(16) => nc6128, 
        B_DOUT(15) => nc4895, B_DOUT(14) => nc3674, B_DOUT(13)
         => nc165, B_DOUT(12) => nc4982, B_DOUT(11) => nc2734, 
        B_DOUT(10) => nc4415, B_DOUT(9) => nc5518, B_DOUT(8) => 
        nc5582, B_DOUT(7) => nc5830, B_DOUT(6) => nc3386, 
        B_DOUT(5) => nc2790, B_DOUT(4) => nc2683, B_DOUT(3) => 
        nc384, B_DOUT(2) => nc3890, B_DOUT(1) => nc5396, 
        B_DOUT(0) => nc5119, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][39]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(39), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C8 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%8%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc474, A_DOUT(18) => nc1011, 
        A_DOUT(17) => nc2689, A_DOUT(16) => nc2330, A_DOUT(15)
         => nc999, A_DOUT(14) => nc4223, A_DOUT(13) => nc5060, 
        A_DOUT(12) => nc198, A_DOUT(11) => nc1089, A_DOUT(10) => 
        nc4411, A_DOUT(9) => nc1238, A_DOUT(8) => nc282, 
        A_DOUT(7) => nc2817, A_DOUT(6) => nc5304, A_DOUT(5) => 
        nc5344, A_DOUT(4) => nc3607, A_DOUT(3) => nc3108, 
        A_DOUT(2) => nc4227, A_DOUT(1) => nc6077, A_DOUT(0) => 
        \R_DATA_TEMPR2[8]\, B_DOUT(19) => nc2536, B_DOUT(18) => 
        nc742, B_DOUT(17) => nc2681, B_DOUT(16) => nc1917, 
        B_DOUT(15) => nc3343, B_DOUT(14) => nc3558, B_DOUT(13)
         => nc4797, B_DOUT(12) => nc3768, B_DOUT(11) => nc4687, 
        B_DOUT(10) => nc4188, B_DOUT(9) => nc3685, B_DOUT(8) => 
        nc447, B_DOUT(7) => nc5256, B_DOUT(6) => nc5763, 
        B_DOUT(5) => nc5695, B_DOUT(4) => nc2894, B_DOUT(3) => 
        nc3159, B_DOUT(2) => nc2642, B_DOUT(1) => nc354, 
        B_DOUT(0) => nc2071, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][8]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(8), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C28 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%28%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2323, A_DOUT(18) => nc4568, 
        A_DOUT(17) => nc3528, A_DOUT(16) => nc3903, A_DOUT(15)
         => nc1014, A_DOUT(14) => nc2504, A_DOUT(13) => nc4169, 
        A_DOUT(12) => nc3129, A_DOUT(11) => nc505, A_DOUT(10) => 
        nc892, A_DOUT(9) => nc3809, A_DOUT(8) => nc264, A_DOUT(7)
         => nc252, A_DOUT(6) => nc1676, A_DOUT(5) => nc2994, 
        A_DOUT(4) => nc1995, A_DOUT(3) => nc4983, A_DOUT(2) => 
        nc3569, A_DOUT(1) => nc4889, A_DOUT(0) => 
        \R_DATA_TEMPR0[28]\, B_DOUT(19) => nc3384, B_DOUT(18) => 
        nc1929, B_DOUT(17) => nc5484, B_DOUT(16) => nc2977, 
        B_DOUT(15) => nc3979, B_DOUT(14) => nc5394, B_DOUT(13)
         => nc2017, B_DOUT(12) => nc54, B_DOUT(11) => nc1041, 
        B_DOUT(10) => nc6117, B_DOUT(9) => nc5524, B_DOUT(8) => 
        nc2135, B_DOUT(7) => nc5581, B_DOUT(6) => nc4114, 
        B_DOUT(5) => nc1060, B_DOUT(4) => nc533, B_DOUT(3) => 
        nc2901, B_DOUT(2) => nc339, B_DOUT(1) => nc664, B_DOUT(0)
         => nc5778, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][28]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(28), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C3 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%3%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4399, A_DOUT(18) => nc2074, 
        A_DOUT(17) => nc781, A_DOUT(16) => nc6078, A_DOUT(15) => 
        nc6080, A_DOUT(14) => nc4553, A_DOUT(13) => nc3533, 
        A_DOUT(12) => nc6113, A_DOUT(11) => nc6110, A_DOUT(10)
         => nc1397, A_DOUT(9) => nc1947, A_DOUT(8) => nc5654, 
        A_DOUT(7) => nc1584, A_DOUT(6) => nc737, A_DOUT(5) => 
        nc4952, A_DOUT(4) => nc3932, A_DOUT(3) => nc4072, 
        A_DOUT(2) => nc4016, A_DOUT(1) => nc3616, A_DOUT(0) => 
        \R_DATA_TEMPR1[3]\, B_DOUT(19) => nc2553, B_DOUT(18) => 
        nc2398, B_DOUT(17) => nc6214, B_DOUT(16) => nc6215, 
        B_DOUT(15) => nc20, B_DOUT(14) => nc2618, B_DOUT(13) => 
        nc588, B_DOUT(12) => nc1763, B_DOUT(11) => nc5921, 
        B_DOUT(10) => nc5565, B_DOUT(9) => nc2952, B_DOUT(8) => 
        nc314, B_DOUT(7) => nc784, B_DOUT(6) => nc986, B_DOUT(5)
         => nc3966, B_DOUT(4) => nc4726, B_DOUT(3) => nc5579, 
        B_DOUT(2) => nc2210, B_DOUT(1) => nc5500, B_DOUT(0) => 
        nc1044, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][3]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(3), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C5 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%5%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2335, A_DOUT(18) => nc171, 
        A_DOUT(17) => nc3940, A_DOUT(16) => nc212, A_DOUT(15) => 
        nc5540, A_DOUT(14) => nc6202, A_DOUT(13) => nc4823, 
        A_DOUT(12) => nc4442, A_DOUT(11) => nc4292, A_DOUT(10)
         => nc1891, A_DOUT(9) => nc6029, A_DOUT(8) => nc3445, 
        A_DOUT(7) => nc692, A_DOUT(6) => nc1708, A_DOUT(5) => 
        nc1981, A_DOUT(4) => nc4935, A_DOUT(3) => nc751, 
        A_DOUT(2) => nc5383, A_DOUT(1) => nc4577, A_DOUT(0) => 
        \R_DATA_TEMPR1[5]\, B_DOUT(19) => nc2920, B_DOUT(18) => 
        nc2018, B_DOUT(17) => nc5400, B_DOUT(16) => nc2633, 
        B_DOUT(15) => nc1191, B_DOUT(14) => nc4998, B_DOUT(13)
         => nc4657, B_DOUT(12) => nc4158, B_DOUT(11) => nc3637, 
        B_DOUT(10) => nc3138, B_DOUT(9) => nc5440, B_DOUT(8) => 
        nc5231, B_DOUT(7) => nc2425, B_DOUT(6) => nc2639, 
        B_DOUT(5) => nc3291, B_DOUT(4) => nc558, B_DOUT(3) => 
        nc2657, B_DOUT(2) => nc2158, B_DOUT(1) => nc3441, 
        B_DOUT(0) => nc754, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][5]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(5), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[6]\ : OR4
      port map(A => \R_DATA_TEMPR0[6]\, B => \R_DATA_TEMPR1[6]\, 
        C => \R_DATA_TEMPR2[6]\, D => \R_DATA_TEMPR3[6]\, Y => 
        R_DATA(6));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C24 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%24%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2965, A_DOUT(18) => nc956, 
        A_DOUT(17) => nc1578, A_DOUT(16) => nc900, A_DOUT(15) => 
        nc4810, A_DOUT(14) => nc2583, A_DOUT(13) => nc1458, 
        A_DOUT(12) => nc5033, A_DOUT(11) => nc2293, A_DOUT(10)
         => nc277, A_DOUT(9) => nc1179, A_DOUT(8) => nc1509, 
        A_DOUT(7) => nc3093, A_DOUT(6) => nc3009, A_DOUT(5) => 
        nc2982, A_DOUT(4) => nc390, A_DOUT(3) => nc4775, 
        A_DOUT(2) => nc5976, A_DOUT(1) => nc4701, A_DOUT(0) => 
        \R_DATA_TEMPR3[24]\, B_DOUT(19) => nc2421, B_DOUT(18) => 
        nc4337, B_DOUT(17) => nc4792, B_DOUT(16) => nc2631, 
        B_DOUT(15) => nc3580, B_DOUT(14) => nc623, B_DOUT(13) => 
        nc4953, B_DOUT(12) => nc3933, B_DOUT(11) => nc78, 
        B_DOUT(10) => nc5590, B_DOUT(9) => nc3769, B_DOUT(8) => 
        nc1896, B_DOUT(7) => nc4089, B_DOUT(6) => nc498, 
        B_DOUT(5) => nc4859, B_DOUT(4) => nc3839, B_DOUT(3) => 
        nc923, B_DOUT(2) => nc5959, B_DOUT(1) => nc1565, 
        B_DOUT(0) => nc2297, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][24]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(24), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[38]\ : OR4
      port map(A => \R_DATA_TEMPR0[38]\, B => \R_DATA_TEMPR1[38]\, 
        C => \R_DATA_TEMPR2[38]\, D => \R_DATA_TEMPR3[38]\, Y => 
        R_DATA(38));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C23 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%23%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2953, A_DOUT(18) => nc921, 
        A_DOUT(17) => nc2859, A_DOUT(16) => nc5463, A_DOUT(15)
         => nc2367, A_DOUT(14) => nc2000, A_DOUT(13) => nc3480, 
        A_DOUT(12) => nc174, A_DOUT(11) => nc6071, A_DOUT(10) => 
        nc5837, A_DOUT(9) => nc5562, A_DOUT(8) => nc5490, 
        A_DOUT(7) => nc3897, A_DOUT(6) => nc1898, A_DOUT(5) => 
        nc661, A_DOUT(4) => nc442, A_DOUT(3) => nc3518, A_DOUT(2)
         => nc4831, A_DOUT(1) => nc1356, A_DOUT(0) => 
        \R_DATA_TEMPR2[23]\, B_DOUT(19) => nc711, B_DOUT(18) => 
        nc5711, B_DOUT(17) => nc1790, B_DOUT(16) => nc1935, 
        B_DOUT(15) => nc3119, B_DOUT(14) => nc2687, B_DOUT(13)
         => nc2188, B_DOUT(12) => nc62, B_DOUT(11) => nc5020, 
        B_DOUT(10) => nc1906, B_DOUT(9) => nc4670, B_DOUT(8) => 
        nc4131, B_DOUT(7) => nc75, B_DOUT(6) => nc3268, B_DOUT(5)
         => nc2703, B_DOUT(4) => nc518, B_DOUT(3) => nc3144, 
        B_DOUT(2) => nc714, B_DOUT(1) => nc47, B_DOUT(0) => nc916, 
        DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY => 
        \ACCESS_BUSY[2][23]\, A_ADDR(13) => R_ADDR(13), 
        A_ADDR(12) => R_ADDR(12), A_ADDR(11) => R_ADDR(11), 
        A_ADDR(10) => R_ADDR(10), A_ADDR(9) => R_ADDR(9), 
        A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), A_ADDR(6)
         => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4) => 
        R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => R_ADDR(2), 
        A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(23), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[36]\ : OR4
      port map(A => \R_DATA_TEMPR0[36]\, B => \R_DATA_TEMPR1[36]\, 
        C => \R_DATA_TEMPR2[36]\, D => \R_DATA_TEMPR3[36]\, Y => 
        R_DATA(36));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C0 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2861, A_DOUT(18) => nc2448, 
        A_DOUT(17) => nc5779, A_DOUT(16) => nc5980, A_DOUT(15)
         => nc827, A_DOUT(14) => nc2124, A_DOUT(13) => nc13, 
        A_DOUT(12) => nc2983, A_DOUT(11) => nc1080, A_DOUT(10)
         => nc2161, A_DOUT(9) => nc786, A_DOUT(8) => nc830, 
        A_DOUT(7) => nc2011, A_DOUT(6) => nc1655, A_DOUT(5) => 
        nc6074, A_DOUT(4) => nc5723, A_DOUT(3) => nc5485, 
        A_DOUT(2) => nc2889, A_DOUT(1) => nc3046, A_DOUT(0) => 
        \R_DATA_TEMPR2[0]\, B_DOUT(19) => nc3751, B_DOUT(18) => 
        nc1337, B_DOUT(17) => nc6206, B_DOUT(16) => nc4296, 
        B_DOUT(15) => nc431, B_DOUT(14) => nc1894, B_DOUT(13) => 
        nc4836, B_DOUT(12) => nc1412, B_DOUT(11) => nc5037, 
        B_DOUT(10) => nc871, B_DOUT(9) => nc4075, B_DOUT(8) => 
        nc924, B_DOUT(7) => nc3097, B_DOUT(6) => nc3504, 
        B_DOUT(5) => nc5606, B_DOUT(4) => nc1463, B_DOUT(3) => 
        nc2026, B_DOUT(2) => nc4761, B_DOUT(1) => nc3721, 
        B_DOUT(0) => nc5646, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][0]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(0), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[18]\ : OR4
      port map(A => \R_DATA_TEMPR0[18]\, B => \R_DATA_TEMPR1[18]\, 
        C => \R_DATA_TEMPR2[18]\, D => \R_DATA_TEMPR3[18]\, Y => 
        R_DATA(18));
    
    \OR4_R_DATA[16]\ : OR4
      port map(A => \R_DATA_TEMPR0[16]\, B => \R_DATA_TEMPR1[16]\, 
        C => \R_DATA_TEMPR2[16]\, D => \R_DATA_TEMPR3[16]\, Y => 
        R_DATA(16));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C22 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%22%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5481, A_DOUT(18) => nc1562, 
        A_DOUT(17) => nc4584, A_DOUT(16) => nc409, A_DOUT(15) => 
        nc600, A_DOUT(14) => nc4022, A_DOUT(13) => nc2917, 
        A_DOUT(12) => nc1783, A_DOUT(11) => nc5464, A_DOUT(10)
         => nc4838, A_DOUT(9) => nc1994, A_DOUT(8) => nc420, 
        A_DOUT(7) => nc2866, A_DOUT(6) => nc2346, A_DOUT(5) => 
        nc2796, A_DOUT(4) => nc5278, A_DOUT(3) => nc1354, 
        A_DOUT(2) => nc1709, A_DOUT(1) => nc5561, A_DOUT(0) => 
        \R_DATA_TEMPR0[22]\, B_DOUT(19) => nc1831, B_DOUT(18) => 
        nc4730, B_DOUT(17) => nc756, B_DOUT(16) => nc2893, 
        B_DOUT(15) => nc71, B_DOUT(14) => nc5638, B_DOUT(13) => 
        nc6151, B_DOUT(12) => nc4059, B_DOUT(11) => nc3901, 
        B_DOUT(10) => nc3039, B_DOUT(9) => nc2014, B_DOUT(8) => 
        nc495, B_DOUT(7) => nc393, B_DOUT(6) => nc3698, B_DOUT(5)
         => nc2472, B_DOUT(4) => nc2868, B_DOUT(3) => nc1322, 
        B_DOUT(2) => nc2505, B_DOUT(1) => nc1131, B_DOUT(0) => 
        nc3372, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][22]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(22), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C17 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%17%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc629, A_DOUT(18) => nc295, 
        A_DOUT(17) => nc2059, A_DOUT(16) => nc5230, A_DOUT(15)
         => nc4981, A_DOUT(14) => nc968, A_DOUT(13) => nc3840, 
        A_DOUT(12) => nc3290, A_DOUT(11) => nc4527, A_DOUT(10)
         => nc2760, A_DOUT(9) => nc2533, A_DOUT(8) => nc9, 
        A_DOUT(7) => nc2645, A_DOUT(6) => nc586, A_DOUT(5) => 
        nc521, A_DOUT(4) => nc3686, A_DOUT(3) => nc4694, 
        A_DOUT(2) => nc2932, A_DOUT(1) => nc4211, A_DOUT(0) => 
        \R_DATA_TEMPR2[17]\, B_DOUT(19) => nc5696, B_DOUT(18) => 
        nc5525, B_DOUT(17) => nc677, B_DOUT(16) => nc1398, 
        B_DOUT(15) => nc2820, B_DOUT(14) => nc1442, B_DOUT(13)
         => nc1208, B_DOUT(12) => nc5038, B_DOUT(11) => nc4834, 
        B_DOUT(10) => nc3098, B_DOUT(9) => nc1836, B_DOUT(8) => 
        nc4013, B_DOUT(7) => nc5184, B_DOUT(6) => nc4725, 
        B_DOUT(5) => nc4172, B_DOUT(4) => nc1127, B_DOUT(3) => 
        nc3177, B_DOUT(2) => nc1585, B_DOUT(1) => nc5363, 
        B_DOUT(0) => nc1464, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][17]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(17), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C25 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%25%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc6135, A_DOUT(18) => nc4934, 
        A_DOUT(17) => nc2344, A_DOUT(16) => nc2864, A_DOUT(15)
         => nc1838, A_DOUT(14) => nc325, A_DOUT(13) => nc4748, 
        A_DOUT(12) => nc1561, A_DOUT(11) => nc716, A_DOUT(10) => 
        nc556, A_DOUT(9) => nc826, A_DOUT(8) => nc5086, A_DOUT(7)
         => nc4704, A_DOUT(6) => nc2637, A_DOUT(5) => nc298, 
        A_DOUT(4) => nc2089, A_DOUT(3) => nc2138, A_DOUT(2) => 
        nc249, A_DOUT(1) => nc5508, A_DOUT(0) => 
        \R_DATA_TEMPR0[25]\, B_DOUT(19) => nc4817, B_DOUT(18) => 
        nc1730, B_DOUT(17) => nc1123, B_DOUT(16) => nc1120, 
        B_DOUT(15) => nc4371, B_DOUT(14) => nc6020, B_DOUT(13)
         => nc3173, B_DOUT(12) => nc3170, B_DOUT(11) => nc271, 
        B_DOUT(10) => nc426, B_DOUT(9) => nc322, B_DOUT(8) => 
        nc5548, B_DOUT(7) => nc5109, B_DOUT(6) => nc2964, 
        B_DOUT(5) => nc1224, B_DOUT(4) => nc1427, B_DOUT(3) => 
        nc3274, B_DOUT(2) => nc1225, B_DOUT(1) => nc3477, 
        B_DOUT(0) => nc3275, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][25]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(25), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C10 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%10%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5149, A_DOUT(18) => nc4300, 
        A_DOUT(17) => nc2403, A_DOUT(16) => nc1771, A_DOUT(15)
         => nc1293, A_DOUT(14) => nc4554, A_DOUT(13) => nc3534, 
        A_DOUT(12) => nc2502, A_DOUT(11) => nc186, A_DOUT(10) => 
        nc4620, A_DOUT(9) => nc1550, A_DOUT(8) => nc4549, 
        A_DOUT(7) => nc2933, A_DOUT(6) => nc780, A_DOUT(5) => 
        nc2554, A_DOUT(4) => nc82, A_DOUT(3) => nc2839, A_DOUT(2)
         => nc4338, A_DOUT(1) => nc4506, A_DOUT(0) => 
        \R_DATA_TEMPR2[10]\, B_DOUT(19) => nc334, B_DOUT(18) => 
        nc4999, B_DOUT(17) => nc1297, B_DOUT(16) => nc5714, 
        B_DOUT(15) => nc5423, B_DOUT(14) => nc3000, B_DOUT(13)
         => nc688, B_DOUT(12) => nc1834, B_DOUT(11) => nc5522, 
        B_DOUT(10) => nc1450, B_DOUT(9) => nc925, B_DOUT(8) => 
        nc5352, B_DOUT(7) => nc232, B_DOUT(6) => nc4080, 
        B_DOUT(5) => nc96, B_DOUT(4) => nc5310, B_DOUT(3) => 
        nc3588, B_DOUT(2) => nc2368, B_DOUT(1) => nc1363, 
        B_DOUT(0) => nc4951, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][10]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(10), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C29 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%29%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3931, A_DOUT(18) => nc5880, 
        A_DOUT(17) => nc5598, A_DOUT(16) => nc4017, A_DOUT(15)
         => nc3965, A_DOUT(14) => nc4025, A_DOUT(13) => nc3189, 
        A_DOUT(12) => nc3711, A_DOUT(11) => nc1483, A_DOUT(10)
         => nc1934, A_DOUT(9) => nc2951, A_DOUT(8) => nc5199, 
        A_DOUT(7) => nc5031, A_DOUT(6) => nc516, A_DOUT(5) => 
        nc2092, A_DOUT(4) => nc3703, A_DOUT(3) => nc3091, 
        A_DOUT(2) => nc156, A_DOUT(1) => nc1582, A_DOUT(0) => 
        \R_DATA_TEMPR3[29]\, B_DOUT(19) => nc4279, B_DOUT(18) => 
        nc5516, B_DOUT(17) => nc750, B_DOUT(16) => nc3754, 
        B_DOUT(15) => nc4946, B_DOUT(14) => nc4783, B_DOUT(13)
         => nc5960, B_DOUT(12) => nc658, B_DOUT(11) => nc844, 
        B_DOUT(10) => nc4105, B_DOUT(9) => nc2584, B_DOUT(8) => 
        nc5465, B_DOUT(7) => nc1622, B_DOUT(6) => nc5937, 
        B_DOUT(5) => nc4764, B_DOUT(4) => nc3724, B_DOUT(3) => 
        nc3672, B_DOUT(2) => nc3350, B_DOUT(1) => nc5157, 
        B_DOUT(0) => nc2540, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][29]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(29), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C2 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%2%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc795, A_DOUT(18) => nc4233, 
        A_DOUT(17) => nc3997, A_DOUT(16) => nc4618, A_DOUT(15)
         => nc3367, A_DOUT(14) => nc3241, A_DOUT(13) => nc2404, 
        A_DOUT(12) => nc2597, A_DOUT(11) => nc162, A_DOUT(10) => 
        nc367, A_DOUT(9) => nc4360, A_DOUT(8) => nc3320, 
        A_DOUT(7) => nc2501, A_DOUT(6) => nc4210, A_DOUT(5) => 
        nc1338, A_DOUT(4) => nc4237, A_DOUT(3) => nc6195, 
        A_DOUT(2) => nc5461, A_DOUT(1) => nc3556, A_DOUT(0) => 
        \R_DATA_TEMPR3[2]\, B_DOUT(19) => nc2440, B_DOUT(18) => 
        nc2221, B_DOUT(17) => nc5034, B_DOUT(16) => nc3043, 
        B_DOUT(15) => nc5153, B_DOUT(14) => nc5150, B_DOUT(13)
         => nc1718, B_DOUT(12) => nc2263, B_DOUT(11) => nc5975, 
        B_DOUT(10) => nc3094, B_DOUT(9) => nc127, B_DOUT(8) => 
        nc5424, B_DOUT(7) => nc4479, B_DOUT(6) => nc2981, 
        B_DOUT(5) => nc5254, B_DOUT(4) => nc5457, B_DOUT(3) => 
        nc5115, B_DOUT(2) => nc5255, B_DOUT(1) => nc4566, 
        B_DOUT(0) => nc3526, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][2]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(2), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C13 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%13%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4476, A_DOUT(18) => nc4018, 
        A_DOUT(17) => nc2023, A_DOUT(16) => nc5521, A_DOUT(15)
         => nc1796, A_DOUT(14) => nc731, A_DOUT(13) => nc3861, 
        A_DOUT(12) => nc4305, A_DOUT(11) => nc2267, A_DOUT(10)
         => nc2795, A_DOUT(9) => nc2412, A_DOUT(8) => nc280, 
        A_DOUT(7) => nc116, A_DOUT(6) => nc4749, A_DOUT(5) => 
        nc3505, A_DOUT(4) => nc4122, A_DOUT(3) => nc1893, 
        A_DOUT(2) => nc710, A_DOUT(1) => nc2039, A_DOUT(0) => 
        \R_DATA_TEMPR0[13]\, B_DOUT(19) => nc293, B_DOUT(18) => 
        nc3161, B_DOUT(17) => nc3847, B_DOUT(16) => nc538, 
        B_DOUT(15) => nc1484, B_DOUT(14) => nc734, B_DOUT(13) => 
        nc1519, B_DOUT(12) => nc4176, B_DOUT(11) => nc936, 
        B_DOUT(10) => nc4603, B_DOUT(9) => nc4585, B_DOUT(8) => 
        nc1960, B_DOUT(7) => nc5377, B_DOUT(6) => nc618, 
        B_DOUT(5) => nc4872, B_DOUT(4) => nc1581, B_DOUT(3) => 
        nc4875, B_DOUT(2) => nc2778, B_DOUT(1) => nc4609, 
        B_DOUT(0) => nc1465, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][13]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(13), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C18 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%18%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc582, A_DOUT(18) => nc2827, 
        A_DOUT(17) => nc3155, A_DOUT(16) => nc1905, A_DOUT(15)
         => nc4050, A_DOUT(14) => nc3030, A_DOUT(13) => nc1656, 
        A_DOUT(12) => nc321, A_DOUT(11) => nc2, A_DOUT(10) => 
        nc4321, A_DOUT(9) => nc2303, A_DOUT(8) => nc5315, 
        A_DOUT(7) => nc708, A_DOUT(6) => nc1233, A_DOUT(5) => 
        nc2050, A_DOUT(4) => nc3866, A_DOUT(3) => nc5164, 
        A_DOUT(2) => nc4165, A_DOUT(1) => nc3125, A_DOUT(0) => 
        \R_DATA_TEMPR1[18]\, B_DOUT(19) => nc989, B_DOUT(18) => 
        nc4601, B_DOUT(17) => nc250, B_DOUT(16) => nc1461, 
        B_DOUT(15) => nc4248, B_DOUT(14) => nc2690, B_DOUT(13)
         => nc188, B_DOUT(12) => nc1748, B_DOUT(11) => nc1237, 
        B_DOUT(10) => nc5871, B_DOUT(9) => nc898, B_DOUT(8) => 
        nc573, B_DOUT(7) => nc5613, B_DOUT(6) => nc2579, 
        B_DOUT(5) => nc379, B_DOUT(4) => nc5323, B_DOUT(3) => 
        nc4753, B_DOUT(2) => nc3733, B_DOUT(1) => nc5619, 
        B_DOUT(0) => nc34, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][18]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(18), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C38 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%38%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3868, A_DOUT(18) => nc1307, 
        A_DOUT(17) => nc1916, A_DOUT(16) => nc4777, A_DOUT(15)
         => nc2753, A_DOUT(14) => nc5171, A_DOUT(13) => nc5066, 
        A_DOUT(12) => nc5652, A_DOUT(11) => nc3047, A_DOUT(10)
         => nc777, A_DOUT(9) => nc1774, A_DOUT(8) => nc4736, 
        A_DOUT(7) => nc552, A_DOUT(6) => nc843, A_DOUT(5) => 
        nc3355, A_DOUT(4) => nc5281, A_DOUT(3) => nc3760, 
        A_DOUT(2) => nc73, A_DOUT(1) => nc149, A_DOUT(0) => 
        \R_DATA_TEMPR2[38]\, B_DOUT(19) => nc4833, B_DOUT(18) => 
        nc1383, B_DOUT(17) => nc565, B_DOUT(16) => nc5701, 
        B_DOUT(15) => nc2027, B_DOUT(14) => nc1549, B_DOUT(13)
         => nc2095, B_DOUT(12) => nc5611, B_DOUT(11) => nc3403, 
        B_DOUT(10) => nc1370, B_DOUT(9) => nc5741, B_DOUT(8) => 
        nc4365, B_DOUT(7) => nc3325, B_DOUT(6) => nc959, 
        B_DOUT(5) => nc5083, B_DOUT(4) => nc3502, B_DOUT(3) => 
        nc2766, B_DOUT(2) => nc3653, B_DOUT(1) => nc882, 
        B_DOUT(0) => nc158, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][38]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(38), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[5]\ : OR4
      port map(A => \R_DATA_TEMPR0[5]\, B => \R_DATA_TEMPR1[5]\, 
        C => \R_DATA_TEMPR2[5]\, D => \R_DATA_TEMPR3[5]\, Y => 
        R_DATA(5));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C7 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%7%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2080, A_DOUT(18) => nc4483, 
        A_DOUT(17) => nc4011, A_DOUT(16) => nc2646, A_DOUT(15)
         => nc2534, A_DOUT(14) => nc1801, A_DOUT(13) => nc5876, 
        A_DOUT(12) => nc743, A_DOUT(11) => nc3659, A_DOUT(10) => 
        nc4229, A_DOUT(9) => nc4582, A_DOUT(8) => nc2863, 
        A_DOUT(7) => nc1576, A_DOUT(6) => nc3648, A_DOUT(5) => 
        nc2976, A_DOUT(4) => nc4663, A_DOUT(3) => nc3623, 
        A_DOUT(2) => nc1101, A_DOUT(1) => nc749, A_DOUT(0) => 
        \R_DATA_TEMPR2[7]\, B_DOUT(19) => nc3714, B_DOUT(18) => 
        nc1164, B_DOUT(17) => nc3864, B_DOUT(16) => nc4669, 
        B_DOUT(15) => nc3629, B_DOUT(14) => nc210, B_DOUT(13) => 
        nc3240, B_DOUT(12) => nc5878, B_DOUT(11) => nc2628, 
        B_DOUT(10) => nc5887, B_DOUT(9) => nc4917, B_DOUT(8) => 
        nc4379, B_DOUT(7) => nc2783, B_DOUT(6) => nc3651, 
        B_DOUT(5) => nc5860, B_DOUT(4) => nc907, B_DOUT(3) => 
        nc4392, B_DOUT(2) => nc1719, B_DOUT(1) => nc1558, 
        B_DOUT(0) => nc4555, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][7]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(7), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C5 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%5%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3535, A_DOUT(18) => nc6184, 
        A_DOUT(17) => nc2900, A_DOUT(16) => nc5770, A_DOUT(15)
         => nc3310, A_DOUT(14) => nc2931, A_DOUT(13) => nc2220, 
        A_DOUT(12) => nc6138, A_DOUT(11) => nc1946, A_DOUT(10)
         => nc3781, A_DOUT(9) => nc26, A_DOUT(8) => nc3964, 
        A_DOUT(7) => nc1159, A_DOUT(6) => nc3048, A_DOUT(5) => 
        nc2555, A_DOUT(4) => nc1066, A_DOUT(3) => nc2405, 
        A_DOUT(2) => nc852, A_DOUT(1) => nc512, A_DOUT(0) => 
        \R_DATA_TEMPR0[5]\, B_DOUT(19) => nc5791, B_DOUT(18) => 
        nc4661, B_DOUT(17) => nc3621, B_DOUT(16) => nc1428, 
        B_DOUT(15) => nc736, B_DOUT(14) => nc1806, B_DOUT(13) => 
        nc4014, B_DOUT(12) => nc3478, B_DOUT(11) => nc1092, 
        B_DOUT(10) => nc1736, B_DOUT(9) => nc3516, B_DOUT(8) => 
        nc4429, B_DOUT(7) => nc443, B_DOUT(6) => nc5920, 
        B_DOUT(5) => nc2028, B_DOUT(4) => nc6086, B_DOUT(3) => 
        nc1175, B_DOUT(2) => nc1833, B_DOUT(1) => nc4426, 
        B_DOUT(0) => nc919, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][5]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(5), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C6 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%6%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5425, A_DOUT(18) => nc2401, 
        A_DOUT(17) => nc4272, A_DOUT(16) => nc118, A_DOUT(15) => 
        nc1808, A_DOUT(14) => nc2192, A_DOUT(13) => nc825, 
        A_DOUT(12) => nc3404, A_DOUT(11) => nc2779, A_DOUT(10)
         => nc1218, A_DOUT(9) => nc6107, A_DOUT(8) => nc5874, 
        A_DOUT(7) => nc4197, A_DOUT(6) => nc682, A_DOUT(5) => 
        nc246, A_DOUT(4) => nc1700, A_DOUT(3) => nc3501, 
        A_DOUT(2) => nc1980, A_DOUT(1) => nc4484, A_DOUT(0) => 
        \R_DATA_TEMPR2[6]\, B_DOUT(19) => nc5432, B_DOUT(18) => 
        nc5087, B_DOUT(17) => nc4978, B_DOUT(16) => nc4126, 
        B_DOUT(15) => nc4503, B_DOUT(14) => nc3492, B_DOUT(13)
         => nc3368, B_DOUT(12) => nc5421, B_DOUT(11) => nc1597, 
        B_DOUT(10) => nc4822, B_DOUT(9) => nc520, B_DOUT(8) => 
        nc1485, B_DOUT(7) => nc942, B_DOUT(6) => nc4825, 
        B_DOUT(5) => nc960, B_DOUT(4) => nc4902, B_DOUT(3) => 
        nc1326, B_DOUT(2) => nc4581, B_DOUT(1) => nc3376, 
        B_DOUT(0) => nc2391, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][6]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(6), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C28 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%28%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc524, A_DOUT(18) => nc5974, 
        A_DOUT(17) => nc6103, A_DOUT(16) => nc6100, A_DOUT(15)
         => nc4193, A_DOUT(14) => nc4190, A_DOUT(13) => nc2585, 
        A_DOUT(12) => nc2548, A_DOUT(11) => nc1860, A_DOUT(10)
         => nc1749, A_DOUT(9) => nc6204, A_DOUT(8) => nc4294, 
        A_DOUT(7) => nc3115, A_DOUT(6) => nc1375, A_DOUT(5) => 
        nc4497, A_DOUT(4) => nc6205, A_DOUT(3) => nc4295, 
        A_DOUT(2) => nc2149, A_DOUT(1) => nc4772, A_DOUT(0) => 
        \R_DATA_TEMPR1[28]\, B_DOUT(19) => nc380, B_DOUT(18) => 
        nc812, B_DOUT(17) => nc1481, B_DOUT(16) => nc17, 
        B_DOUT(15) => nc4453, B_DOUT(14) => nc3433, B_DOUT(13)
         => nc870, B_DOUT(12) => nc2278, B_DOUT(11) => nc1795, 
        B_DOUT(10) => nc536, B_DOUT(9) => nc4552, B_DOUT(8) => 
        nc3532, B_DOUT(7) => nc5688, B_DOUT(6) => nc2453, 
        B_DOUT(5) => nc1804, B_DOUT(4) => nc652, B_DOUT(3) => 
        nc488, B_DOUT(2) => nc471, B_DOUT(1) => nc5513, B_DOUT(0)
         => nc4032, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][28]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(28), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[9]\ : OR4
      port map(A => \R_DATA_TEMPR0[9]\, B => \R_DATA_TEMPR1[9]\, 
        C => \R_DATA_TEMPR2[9]\, D => \R_DATA_TEMPR3[9]\, Y => 
        R_DATA(9));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C12 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%12%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2718, A_DOUT(18) => nc1673, 
        A_DOUT(17) => nc2552, A_DOUT(16) => nc1625, A_DOUT(15)
         => nc645, A_DOUT(14) => nc5912, A_DOUT(13) => nc3675, 
        A_DOUT(12) => nc5280, A_DOUT(11) => nc2104, A_DOUT(10)
         => nc143, A_DOUT(9) => nc1679, A_DOUT(8) => nc4727, 
        A_DOUT(7) => nc4607, A_DOUT(6) => nc4108, A_DOUT(5) => 
        nc6149, A_DOUT(4) => nc5378, A_DOUT(3) => nc328, 
        A_DOUT(2) => nc1904, A_DOUT(1) => nc3303, A_DOUT(0) => 
        \R_DATA_TEMPR1[12]\, B_DOUT(19) => nc3041, B_DOUT(18) => 
        nc2030, B_DOUT(17) => nc1248, B_DOUT(16) => nc529, 
        B_DOUT(15) => nc2062, B_DOUT(14) => nc3263, B_DOUT(13)
         => nc4945, B_DOUT(12) => nc3315, B_DOUT(11) => nc5088, 
        B_DOUT(10) => nc4383, B_DOUT(9) => nc5124, B_DOUT(8) => 
        nc2006, B_DOUT(7) => nc1671, B_DOUT(6) => nc350, 
        B_DOUT(5) => nc2519, B_DOUT(4) => nc2021, B_DOUT(3) => 
        nc5458, B_DOUT(2) => nc6198, B_DOUT(1) => nc4537, 
        B_DOUT(0) => nc3553, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][12]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(12), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C32 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%32%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2299, A_DOUT(18) => nc3267, 
        A_DOUT(17) => nc1324, A_DOUT(16) => nc4903, A_DOUT(15)
         => nc3374, A_DOUT(14) => nc1690, A_DOUT(13) => nc458, 
        A_DOUT(12) => nc3952, A_DOUT(11) => nc4809, A_DOUT(10)
         => nc3947, A_DOUT(9) => nc3613, A_DOUT(8) => nc2733, 
        A_DOUT(7) => nc5704, A_DOUT(6) => nc5617, A_DOUT(5) => 
        nc5118, A_DOUT(4) => nc5026, A_DOUT(3) => nc4563, 
        A_DOUT(2) => nc3523, A_DOUT(1) => nc3619, A_DOUT(0) => 
        \R_DATA_TEMPR2[32]\, B_DOUT(19) => nc2483, B_DOUT(18) => 
        nc6161, B_DOUT(17) => nc1184, B_DOUT(16) => nc5744, 
        B_DOUT(15) => nc5261, B_DOUT(14) => nc6039, B_DOUT(13)
         => nc693, B_DOUT(12) => nc2567, B_DOUT(11) => nc4962, 
        B_DOUT(10) => nc3922, B_DOUT(9) => nc2927, B_DOUT(8) => 
        nc4692, B_DOUT(7) => nc2582, B_DOUT(6) => nc4276, 
        B_DOUT(5) => nc4347, B_DOUT(4) => nc1308, B_DOUT(3) => 
        nc993, B_DOUT(2) => nc136, B_DOUT(1) => nc4735, B_DOUT(0)
         => nc612, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][32]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(32), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C15 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%15%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5300, A_DOUT(18) => nc991, 
        A_DOUT(17) => nc4329, A_DOUT(16) => nc3044, A_DOUT(15)
         => nc730, A_DOUT(14) => nc4454, A_DOUT(13) => nc3434, 
        A_DOUT(12) => nc702, A_DOUT(11) => nc6052, A_DOUT(10) => 
        nc5340, A_DOUT(9) => nc5063, A_DOUT(8) => nc1032, 
        A_DOUT(7) => nc469, A_DOUT(6) => nc660, A_DOUT(5) => 
        nc3611, A_DOUT(4) => nc1095, A_DOUT(3) => nc5913, 
        A_DOUT(2) => nc1086, A_DOUT(1) => nc5273, A_DOUT(0) => 
        \R_DATA_TEMPR1[15]\, B_DOUT(19) => nc2454, B_DOUT(18) => 
        nc5356, B_DOUT(17) => nc638, B_DOUT(16) => nc407, 
        B_DOUT(15) => nc4551, B_DOUT(14) => nc3531, B_DOUT(13)
         => nc5819, B_DOUT(12) => nc2024, B_DOUT(11) => nc2916, 
        B_DOUT(10) => nc5506, B_DOUT(9) => nc2765, B_DOUT(8) => 
        nc3657, B_DOUT(7) => nc3158, B_DOUT(6) => nc2499, 
        B_DOUT(5) => nc2551, B_DOUT(4) => nc2800, B_DOUT(3) => 
        nc5546, B_DOUT(2) => nc5277, B_DOUT(1) => nc2496, 
        B_DOUT(0) => nc4841, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][15]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(15), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C13 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%13%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc69, A_DOUT(18) => nc310, 
        A_DOUT(17) => nc3784, A_DOUT(16) => nc5867, A_DOUT(15)
         => nc4667, A_DOUT(14) => nc4168, A_DOUT(13) => nc3627, 
        A_DOUT(12) => nc3128, A_DOUT(11) => nc5794, A_DOUT(10)
         => nc4222, A_DOUT(9) => nc4141, A_DOUT(8) => nc485, 
        A_DOUT(7) => nc383, A_DOUT(6) => nc418, A_DOUT(5) => 
        nc5820, A_DOUT(4) => nc1537, A_DOUT(3) => nc4630, 
        A_DOUT(2) => nc3900, A_DOUT(1) => nc3953, A_DOUT(0) => 
        \R_DATA_TEMPR2[13]\, B_DOUT(19) => nc5655, B_DOUT(18) => 
        nc2196, B_DOUT(17) => nc50, B_DOUT(16) => nc285, 
        B_DOUT(15) => nc3380, B_DOUT(14) => nc2535, B_DOUT(13)
         => nc897, B_DOUT(12) => nc3859, B_DOUT(11) => nc2892, 
        B_DOUT(10) => nc5390, B_DOUT(9) => nc3405, B_DOUT(8) => 
        nc2895, B_DOUT(7) => nc4928, B_DOUT(6) => nc4412, 
        B_DOUT(5) => nc1203, B_DOUT(4) => nc4980, B_DOUT(3) => 
        nc4674, B_DOUT(2) => nc1751, B_DOUT(1) => nc6119, 
        B_DOUT(0) => nc1261, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][13]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(13), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C35 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%35%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5081, A_DOUT(18) => nc4963, 
        A_DOUT(17) => nc3923, A_DOUT(16) => nc4485, A_DOUT(15)
         => nc3766, A_DOUT(14) => nc5105, A_DOUT(13) => nc4869, 
        A_DOUT(12) => nc3829, A_DOUT(11) => nc2660, A_DOUT(10)
         => nc2484, A_DOUT(9) => nc1880, A_DOUT(8) => nc3586, 
        A_DOUT(7) => nc994, A_DOUT(6) => nc374, A_DOUT(5) => 
        nc1207, A_DOUT(4) => nc5596, A_DOUT(3) => nc1735, 
        A_DOUT(2) => nc4353, A_DOUT(1) => nc3333, A_DOUT(0) => 
        \R_DATA_TEMPR2[35]\, B_DOUT(19) => nc5145, B_DOUT(18) => 
        nc4846, B_DOUT(17) => nc1063, B_DOUT(16) => nc3863, 
        B_DOUT(15) => nc3401, B_DOUT(14) => nc1520, B_DOUT(13)
         => nc3570, B_DOUT(12) => nc2719, B_DOUT(11) => nc2581, 
        B_DOUT(10) => nc1915, B_DOUT(9) => nc4722, B_DOUT(8) => 
        nc2353, B_DOUT(7) => nc4035, B_DOUT(6) => nc5354, 
        B_DOUT(5) => nc455, B_DOUT(4) => nc353, B_DOUT(3) => 
        nc5987, B_DOUT(2) => nc4481, B_DOUT(1) => nc272, 
        B_DOUT(0) => nc4009, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][35]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(35), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C31 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%31%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc490, A_DOUT(18) => nc1192, 
        A_DOUT(17) => nc6083, A_DOUT(16) => nc5067, A_DOUT(15)
         => nc255, A_DOUT(14) => nc4848, A_DOUT(13) => nc1420, 
        A_DOUT(12) => nc1573, A_DOUT(11) => nc3470, A_DOUT(10)
         => nc2797, A_DOUT(9) => nc1972, A_DOUT(8) => nc2065, 
        A_DOUT(7) => nc1867, A_DOUT(6) => nc4740, A_DOUT(5) => 
        nc288, A_DOUT(4) => nc6124, A_DOUT(3) => nc230, A_DOUT(2)
         => nc5084, A_DOUT(1) => nc6099, A_DOUT(0) => 
        \R_DATA_TEMPR3[31]\, B_DOUT(19) => nc699, B_DOUT(18) => 
        nc5738, B_DOUT(17) => nc5305, B_DOUT(16) => nc3798, 
        B_DOUT(15) => nc1391, B_DOUT(14) => nc1317, B_DOUT(13)
         => nc5776, B_DOUT(12) => nc5345, B_DOUT(11) => nc3185, 
        B_DOUT(10) => nc2975, B_DOUT(9) => nc2218, B_DOUT(8) => 
        nc1630, B_DOUT(7) => nc5195, B_DOUT(6) => nc2741, 
        B_DOUT(5) => nc5019, B_DOUT(4) => nc591, B_DOUT(3) => 
        nc5668, B_DOUT(2) => nc2433, B_DOUT(1) => nc532, 
        B_DOUT(0) => nc6026, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][31]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(31), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C37 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%37%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5873, A_DOUT(18) => nc5603, 
        A_DOUT(17) => nc2532, A_DOUT(16) => nc4979, A_DOUT(15)
         => nc2383, A_DOUT(14) => nc5643, A_DOUT(13) => nc5609, 
        A_DOUT(12) => nc5260, A_DOUT(11) => nc3513, A_DOUT(10)
         => nc3104, A_DOUT(9) => nc5539, A_DOUT(8) => nc5649, 
        A_DOUT(7) => nc4844, A_DOUT(6) => nc346, A_DOUT(5) => 
        nc1178, A_DOUT(4) => nc1677, A_DOUT(3) => nc3912, 
        A_DOUT(2) => nc3599, A_DOUT(1) => nc1945, A_DOUT(0) => 
        \R_DATA_TEMPR0[37]\, B_DOUT(19) => nc1811, B_DOUT(18) => 
        nc939, B_DOUT(17) => nc258, B_DOUT(16) => nc4184, 
        B_DOUT(15) => nc6055, B_DOUT(14) => nc415, B_DOUT(13) => 
        nc313, B_DOUT(12) => nc2399, B_DOUT(11) => nc138, 
        B_DOUT(10) => nc2377, B_DOUT(9) => nc4226, B_DOUT(8) => 
        nc1035, B_DOUT(7) => nc125, B_DOUT(6) => nc5068, 
        B_DOUT(5) => nc4132, B_DOUT(4) => nc215, B_DOUT(3) => 
        nc1111, B_DOUT(2) => nc5601, B_DOUT(1) => nc3059, 
        B_DOUT(0) => nc395, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][37]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(37), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C30 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%30%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1067, A_DOUT(18) => nc1706, 
        A_DOUT(17) => nc3385, A_DOUT(16) => nc3006, A_DOUT(15)
         => nc771, A_DOUT(14) => nc4944, A_DOUT(13) => nc4950, 
        A_DOUT(12) => nc3930, A_DOUT(11) => nc5641, A_DOUT(10)
         => nc5395, A_DOUT(9) => nc896, A_DOUT(8) => nc2201, 
        A_DOUT(7) => nc1973, A_DOUT(6) => nc4504, A_DOUT(5) => 
        nc402, A_DOUT(4) => nc4455, A_DOUT(3) => nc4086, 
        A_DOUT(2) => nc3435, A_DOUT(1) => nc2950, A_DOUT(0) => 
        \R_DATA_TEMPR0[30]\, B_DOUT(19) => nc1803, B_DOUT(18) => 
        nc6087, B_DOUT(17) => nc4498, B_DOUT(16) => nc4069, 
        B_DOUT(15) => nc3029, B_DOUT(14) => nc496, B_DOUT(13) => 
        nc392, B_DOUT(12) => nc1879, B_DOUT(11) => nc1299, 
        B_DOUT(10) => nc578, B_DOUT(9) => nc849, B_DOUT(8) => 
        nc2162, B_DOUT(7) => nc2455, B_DOUT(6) => nc774, 
        B_DOUT(5) => nc3683, B_DOUT(4) => nc1347, B_DOUT(3) => 
        nc976, B_DOUT(2) => nc5550, B_DOUT(1) => nc2003, 
        B_DOUT(0) => nc5693, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][30]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(30), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C22 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%22%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4331, A_DOUT(18) => nc2871, 
        A_DOUT(17) => nc3689, A_DOUT(16) => nc3617, A_DOUT(15)
         => nc3118, A_DOUT(14) => nc5221, A_DOUT(13) => nc5936, 
        A_DOUT(12) => nc2292, A_DOUT(11) => nc1816, A_DOUT(10)
         => nc5699, A_DOUT(9) => nc3996, A_DOUT(8) => nc3442, 
        A_DOUT(7) => nc4451, A_DOUT(6) => nc3431, A_DOUT(5) => 
        nc832, A_DOUT(4) => nc1668, A_DOUT(3) => nc785, A_DOUT(2)
         => nc547, A_DOUT(1) => nc89, A_DOUT(0) => 
        \R_DATA_TEMPR1[22]\, B_DOUT(19) => nc2171, B_DOUT(18) => 
        nc2451, B_DOUT(17) => nc5450, B_DOUT(16) => nc5023, 
        B_DOUT(15) => nc4901, B_DOUT(14) => nc2361, B_DOUT(13)
         => nc2998, B_DOUT(12) => nc2434, B_DOUT(11) => nc1260, 
        B_DOUT(10) => nc4348, B_DOUT(9) => nc2422, B_DOUT(8) => 
        nc1626, B_DOUT(7) => nc5514, B_DOUT(6) => nc3062, 
        B_DOUT(5) => nc3676, B_DOUT(4) => nc3681, B_DOUT(3) => 
        nc1818, B_DOUT(2) => nc6030, B_DOUT(1) => nc5691, 
        B_DOUT(0) => nc2807, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][22]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(22), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C7 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%7%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1841, A_DOUT(18) => nc995, 
        A_DOUT(17) => nc1281, A_DOUT(16) => nc218, A_DOUT(15) => 
        nc4624, A_DOUT(14) => nc3913, A_DOUT(13) => nc2531, 
        A_DOUT(12) => nc4396, A_DOUT(11) => nc3800, A_DOUT(10)
         => nc3819, A_DOUT(9) => nc224, A_DOUT(8) => nc1710, 
        A_DOUT(7) => nc1499, A_DOUT(6) => nc1141, A_DOUT(5) => 
        nc1068, A_DOUT(4) => nc6152, A_DOUT(3) => nc2980, 
        A_DOUT(2) => nc4880, A_DOUT(1) => nc1083, A_DOUT(0) => 
        \R_DATA_TEMPR3[7]\, B_DOUT(19) => nc2876, B_DOUT(18) => 
        nc2792, B_DOUT(17) => nc1132, B_DOUT(16) => nc1496, 
        B_DOUT(15) => nc5827, B_DOUT(14) => nc2485, B_DOUT(13)
         => nc1754, B_DOUT(12) => nc755, B_DOUT(11) => nc140, 
        B_DOUT(10) => nc6088, B_DOUT(9) => nc5911, B_DOUT(8) => 
        nc77, B_DOUT(7) => nc3567, B_DOUT(6) => nc283, B_DOUT(5)
         => nc3554, B_DOUT(4) => nc4239, B_DOUT(3) => nc2878, 
        B_DOUT(2) => nc624, B_DOUT(1) => nc5739, B_DOUT(0) => 
        nc1350, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][7]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(7), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C25 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%25%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4695, A_DOUT(18) => nc3799, 
        A_DOUT(17) => nc1196, A_DOUT(16) => nc5061, A_DOUT(15)
         => nc2481, A_DOUT(14) => nc1846, A_DOUT(13) => nc1892, 
        A_DOUT(12) => nc1331, A_DOUT(11) => nc4154, A_DOUT(10)
         => nc3134, A_DOUT(9) => nc1887, A_DOUT(8) => nc768, 
        A_DOUT(7) => nc1895, A_DOUT(6) => nc4564, A_DOUT(5) => 
        nc3524, A_DOUT(4) => nc1814, A_DOUT(3) => nc2770, 
        A_DOUT(2) => nc5072, A_DOUT(1) => nc4243, A_DOUT(0) => 
        \R_DATA_TEMPR1[25]\, B_DOUT(19) => nc2154, B_DOUT(18) => 
        nc2007, B_DOUT(17) => nc4718, B_DOUT(16) => nc1556, 
        B_DOUT(15) => nc2269, B_DOUT(14) => nc632, B_DOUT(13) => 
        nc3765, B_DOUT(12) => nc2333, B_DOUT(11) => nc1848, 
        B_DOUT(10) => nc3951, B_DOUT(9) => nc5967, B_DOUT(8) => 
        nc4056, B_DOUT(7) => nc3036, B_DOUT(6) => nc1914, 
        B_DOUT(5) => nc4247, B_DOUT(4) => nc197, B_DOUT(3) => 
        nc1079, B_DOUT(2) => nc888, B_DOUT(1) => nc4394, 
        B_DOUT(0) => nc253, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][25]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(25), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C11 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%11%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5503, A_DOUT(18) => nc2056, 
        A_DOUT(17) => nc1740, A_DOUT(16) => nc5027, A_DOUT(15)
         => nc5238, A_DOUT(14) => nc4961, A_DOUT(13) => nc4929, 
        A_DOUT(12) => nc3921, A_DOUT(11) => nc5902, A_DOUT(10)
         => nc5543, A_DOUT(9) => nc3298, A_DOUT(8) => nc4439, 
        A_DOUT(7) => nc5577, A_DOUT(6) => nc5482, A_DOUT(5) => 
        nc2874, A_DOUT(4) => nc5942, A_DOUT(3) => nc2744, 
        A_DOUT(2) => nc4519, A_DOUT(1) => nc1797, A_DOUT(0) => 
        \R_DATA_TEMPR3[11]\, B_DOUT(19) => nc5064, B_DOUT(18) => 
        nc4436, B_DOUT(17) => nc330, B_DOUT(16) => nc2608, 
        B_DOUT(15) => nc1528, B_DOUT(14) => nc776, B_DOUT(13) => 
        nc715, B_DOUT(12) => nc3578, B_DOUT(11) => nc1002, 
        B_DOUT(10) => nc2296, B_DOUT(9) => nc4000, B_DOUT(8) => 
        nc2915, B_DOUT(7) => nc1129, B_DOUT(6) => nc3179, 
        B_DOUT(5) => nc438, B_DOUT(4) => nc1087, B_DOUT(3) => 
        nc5656, B_DOUT(2) => nc2200, B_DOUT(1) => nc2340, 
        B_DOUT(0) => nc2469, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][11]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(11), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C8 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%8%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3660, A_DOUT(18) => nc1155, 
        A_DOUT(17) => nc2974, A_DOUT(16) => nc1239, A_DOUT(15)
         => nc2184, A_DOUT(14) => nc209, A_DOUT(13) => nc1061, 
        A_DOUT(12) => nc4136, A_DOUT(11) => nc2466, A_DOUT(10)
         => nc1318, A_DOUT(9) => nc5775, A_DOUT(8) => nc5628, 
        A_DOUT(7) => nc3019, A_DOUT(6) => nc391, A_DOUT(5) => 
        nc1844, A_DOUT(4) => nc4832, A_DOUT(3) => nc858, 
        A_DOUT(2) => nc4835, A_DOUT(1) => nc6221, A_DOUT(0) => 
        \R_DATA_TEMPR3[8]\, B_DOUT(19) => nc6090, B_DOUT(18) => 
        nc4703, B_DOUT(17) => nc2546, B_DOUT(16) => nc2008, 
        B_DOUT(15) => nc5607, B_DOUT(14) => nc5220, B_DOUT(13)
         => nc5108, B_DOUT(12) => nc4850, B_DOUT(11) => nc3830, 
        B_DOUT(10) => nc6081, B_DOUT(9) => nc3583, B_DOUT(8) => 
        nc1507, B_DOUT(7) => nc5593, B_DOUT(6) => nc5647, 
        B_DOUT(5) => nc5148, B_DOUT(4) => nc6171, B_DOUT(3) => 
        nc5010, B_DOUT(2) => nc2317, B_DOUT(1) => nc2086, 
        B_DOUT(0) => nc3982, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][8]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(8), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C36 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%36%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2850, A_DOUT(18) => nc2166, 
        A_DOUT(17) => nc967, A_DOUT(16) => nc6023, A_DOUT(15) => 
        nc5992, A_DOUT(14) => nc1967, A_DOUT(13) => nc1944, 
        A_DOUT(12) => nc4916, A_DOUT(11) => nc1688, A_DOUT(10)
         => nc2862, A_DOUT(9) => nc4372, A_DOUT(8) => nc2865, 
        A_DOUT(7) => nc213, A_DOUT(6) => nc3065, A_DOUT(5) => 
        nc5028, A_DOUT(4) => nc621, A_DOUT(3) => nc1399, 
        A_DOUT(2) => nc1280, A_DOUT(1) => nc2378, A_DOUT(0) => 
        \R_DATA_TEMPR3[36]\, B_DOUT(19) => nc1355, B_DOUT(18) => 
        nc5903, B_DOUT(17) => nc3201, B_DOUT(16) => nc2694, 
        B_DOUT(15) => nc2930, B_DOUT(14) => nc1574, B_DOUT(13)
         => nc5809, B_DOUT(12) => nc1705, B_DOUT(11) => nc1439, 
        B_DOUT(10) => nc5943, B_DOUT(9) => nc1064, B_DOUT(8) => 
        nc5713, B_DOUT(7) => nc4746, B_DOUT(6) => nc4737, 
        B_DOUT(5) => nc576, B_DOUT(4) => nc5670, B_DOUT(3) => 
        nc5849, B_DOUT(2) => nc4281, B_DOUT(1) => nc2435, 
        B_DOUT(0) => nc2811, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][36]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(36), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C30 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%30%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1436, A_DOUT(18) => nc3003, 
        A_DOUT(17) => nc3050, A_DOUT(16) => nc1088, A_DOUT(15)
         => nc1653, A_DOUT(14) => nc4843, A_DOUT(13) => nc1213, 
        A_DOUT(12) => nc2145, A_DOUT(11) => nc6084, A_DOUT(10)
         => nc3687, A_DOUT(9) => nc3188, A_DOUT(8) => nc4590, 
        A_DOUT(7) => nc1659, A_DOUT(6) => nc2111, A_DOUT(5) => 
        nc4083, A_DOUT(4) => nc5697, A_DOUT(3) => nc5198, 
        A_DOUT(2) => nc1348, A_DOUT(1) => nc2767, A_DOUT(0) => 
        \R_DATA_TEMPR1[30]\, B_DOUT(19) => nc6156, B_DOUT(18) => 
        nc4177, B_DOUT(17) => nc818, B_DOUT(16) => nc1292, 
        B_DOUT(15) => nc4060, B_DOUT(14) => nc3020, B_DOUT(13)
         => nc2431, B_DOUT(12) => nc1136, B_DOUT(11) => nc646, 
        B_DOUT(10) => nc1217, B_DOUT(9) => nc2880, B_DOUT(8) => 
        nc1971, B_DOUT(7) => nc1832, B_DOUT(6) => nc1835, 
        B_DOUT(5) => nc4505, B_DOUT(4) => nc804, B_DOUT(3) => 
        nc3748, B_DOUT(2) => nc5075, B_DOUT(1) => nc4490, 
        B_DOUT(0) => nc3753, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][30]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(30), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C37 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%37%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4719, A_DOUT(18) => nc3807, 
        A_DOUT(17) => nc1651, A_DOUT(16) => nc1998, A_DOUT(15)
         => nc5558, A_DOUT(14) => nc3514, A_DOUT(13) => nc6145, 
        A_DOUT(12) => nc3983, A_DOUT(11) => nc4173, A_DOUT(10)
         => nc4170, A_DOUT(9) => nc1600, A_DOUT(8) => nc5993, 
        A_DOUT(7) => nc3889, A_DOUT(6) => nc5159, A_DOUT(5) => 
        nc4887, A_DOUT(4) => nc2816, A_DOUT(3) => nc2728, 
        A_DOUT(2) => nc435, A_DOUT(1) => nc333, A_DOUT(0) => 
        \R_DATA_TEMPR1[37]\, B_DOUT(19) => nc5899, B_DOUT(18) => 
        nc2273, B_DOUT(17) => nc4763, B_DOUT(16) => nc4274, 
        B_DOUT(15) => nc3723, B_DOUT(14) => nc4477, B_DOUT(13)
         => nc4275, B_DOUT(12) => nc4339, B_DOUT(11) => nc2345, 
        B_DOUT(10) => nc235, B_DOUT(9) => nc3162, B_DOUT(8) => 
        nc6027, B_DOUT(7) => nc2001, B_DOUT(6) => nc1792, 
        B_DOUT(5) => nc2277, B_DOUT(4) => nc3549, B_DOUT(3) => 
        nc2818, B_DOUT(2) => nc176, B_DOUT(1) => nc5515, 
        B_DOUT(0) => nc2999, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][37]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(37), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C28 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%28%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc770, A_DOUT(18) => nc3911, 
        A_DOUT(17) => nc1737, A_DOUT(16) => nc2643, A_DOUT(15)
         => nc2369, A_DOUT(14) => nc4218, A_DOUT(13) => nc1243, 
        A_DOUT(12) => nc5, A_DOUT(11) => nc444, A_DOUT(10) => 
        nc1005, A_DOUT(9) => nc2710, A_DOUT(8) => nc2529, 
        A_DOUT(7) => nc5021, A_DOUT(6) => nc2649, A_DOUT(5) => 
        nc678, A_DOUT(4) => nc3361, A_DOUT(3) => nc2907, 
        A_DOUT(2) => nc895, A_DOUT(1) => nc928, A_DOUT(0) => 
        \R_DATA_TEMPR2[28]\, B_DOUT(19) => nc2134, B_DOUT(18) => 
        nc6062, B_DOUT(17) => nc3007, B_DOUT(16) => nc4232, 
        B_DOUT(15) => nc1247, B_DOUT(14) => nc4087, B_DOUT(13)
         => nc5009, B_DOUT(12) => nc2641, B_DOUT(11) => nc590, 
        B_DOUT(10) => nc3555, B_DOUT(9) => nc1081, B_DOUT(8) => 
        nc6220, B_DOUT(7) => nc5927, B_DOUT(6) => nc2004, 
        B_DOUT(5) => nc4403, B_DOUT(4) => nc5049, B_DOUT(3) => 
        nc4938, B_DOUT(2) => nc594, B_DOUT(1) => nc5935, 
        B_DOUT(0) => nc4251, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][28]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(28), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C16 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%16%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3231, A_DOUT(18) => nc2036, 
        A_DOUT(17) => nc5172, A_DOUT(16) => nc238, A_DOUT(15) => 
        nc3995, A_DOUT(14) => nc4502, A_DOUT(13) => nc3946, 
        A_DOUT(12) => nc2262, A_DOUT(11) => nc1716, A_DOUT(10)
         => nc2814, A_DOUT(9) => nc2251, A_DOUT(8) => nc4565, 
        A_DOUT(7) => nc3525, A_DOUT(6) => nc5462, A_DOUT(5) => 
        nc6028, A_DOUT(4) => nc4053, A_DOUT(3) => nc3033, 
        A_DOUT(2) => nc4672, A_DOUT(1) => nc3608, A_DOUT(0) => 
        \R_DATA_TEMPR3[16]\, B_DOUT(19) => nc1813, B_DOUT(18) => 
        nc5024, B_DOUT(17) => nc2926, B_DOUT(16) => nc1339, 
        B_DOUT(15) => nc1987, B_DOUT(14) => nc683, B_DOUT(13) => 
        nc2968, B_DOUT(12) => nc1070, B_DOUT(11) => nc762, 
        B_DOUT(10) => nc2053, B_DOUT(9) => nc4732, B_DOUT(8) => 
        nc983, B_DOUT(7) => nc4688, B_DOUT(6) => nc4322, 
        B_DOUT(5) => nc1296, B_DOUT(4) => nc5371, B_DOUT(3) => 
        nc2914, B_DOUT(2) => nc981, B_DOUT(1) => nc3200, 
        B_DOUT(0) => nc1721, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][16]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(16), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C33 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%33%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc30, A_DOUT(18) => nc5788, 
        A_DOUT(17) => nc3771, A_DOUT(16) => nc467, A_DOUT(15) => 
        nc4042, A_DOUT(14) => nc5413, A_DOUT(13) => nc5337, 
        A_DOUT(12) => nc803, A_DOUT(11) => nc4696, A_DOUT(10) => 
        nc3397, A_DOUT(9) => nc6115, A_DOUT(8) => nc3269, 
        A_DOUT(7) => nc4280, A_DOUT(6) => nc5512, A_DOUT(5) => 
        nc1084, A_DOUT(4) => nc3089, A_DOUT(3) => nc398, 
        A_DOUT(2) => nc109, A_DOUT(1) => nc4857, A_DOUT(0) => 
        \R_DATA_TEMPR0[33]\, B_DOUT(19) => nc3837, B_DOUT(18) => 
        nc2776, B_DOUT(17) => nc2762, B_DOUT(16) => nc1102, 
        B_DOUT(15) => nc5099, B_DOUT(14) => nc599, B_DOUT(13) => 
        nc1773, B_DOUT(12) => nc3008, B_DOUT(11) => nc2857, 
        B_DOUT(10) => nc2873, B_DOUT(9) => nc2830, B_DOUT(8) => 
        nc1232, B_DOUT(7) => nc1553, B_DOUT(6) => nc68, B_DOUT(5)
         => nc4088, B_DOUT(4) => nc5589, B_DOUT(3) => nc653, 
        B_DOUT(2) => nc2281, B_DOUT(1) => nc1952, B_DOUT(0) => 
        nc3749, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][33]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(33), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[31]\ : OR4
      port map(A => \R_DATA_TEMPR0[31]\, B => \R_DATA_TEMPR1[31]\, 
        C => \R_DATA_TEMPR2[31]\, D => \R_DATA_TEMPR3[31]\, Y => 
        R_DATA(31));
    
    \OR4_R_DATA[11]\ : OR4
      port map(A => \R_DATA_TEMPR0[11]\, B => \R_DATA_TEMPR1[11]\, 
        C => \R_DATA_TEMPR2[11]\, D => \R_DATA_TEMPR3[11]\, Y => 
        R_DATA(11));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C9 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%9%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc703, A_DOUT(18) => nc3010, 
        A_DOUT(17) => nc270, A_DOUT(16) => nc56, A_DOUT(15) => 
        nc5831, A_DOUT(14) => nc953, A_DOUT(13) => nc4547, 
        A_DOUT(12) => nc4127, A_DOUT(11) => nc3891, A_DOUT(10)
         => nc3453, A_DOUT(9) => nc951, A_DOUT(8) => nc2318, 
        A_DOUT(7) => nc1301, A_DOUT(6) => nc1938, A_DOUT(5) => 
        nc1746, A_DOUT(4) => nc4404, A_DOUT(3) => nc3552, 
        A_DOUT(2) => nc92, A_DOUT(1) => nc709, A_DOUT(0) => 
        \R_DATA_TEMPR1[9]\, B_DOUT(19) => nc5504, B_DOUT(18) => 
        nc2729, B_DOUT(17) => nc2083, B_DOUT(16) => nc1462, 
        B_DOUT(15) => nc887, B_DOUT(14) => nc5131, B_DOUT(13) => 
        nc3191, B_DOUT(12) => nc5544, B_DOUT(11) => nc1843, 
        B_DOUT(10) => nc141, B_DOUT(9) => nc4501, B_DOUT(8) => 
        nc4463, B_DOUT(7) => nc3469, B_DOUT(6) => nc3423, 
        B_DOUT(5) => nc572, B_DOUT(4) => nc1694, B_DOUT(3) => 
        nc5279, B_DOUT(2) => nc4562, B_DOUT(1) => nc4123, 
        B_DOUT(0) => nc4120, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][9]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(9), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[29]\ : OR4
      port map(A => \R_DATA_TEMPR0[29]\, B => \R_DATA_TEMPR1[29]\, 
        C => \R_DATA_TEMPR2[29]\, D => \R_DATA_TEMPR3[29]\, Y => 
        R_DATA(29));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C18 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%18%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3713, A_DOUT(18) => nc3522, 
        A_DOUT(17) => nc735, A_DOUT(16) => nc3466, A_DOUT(15) => 
        nc4745, A_DOUT(14) => nc1732, A_DOUT(13) => nc984, 
        A_DOUT(12) => nc4236, A_DOUT(11) => nc4224, A_DOUT(10)
         => nc4427, A_DOUT(9) => nc4225, A_DOUT(8) => nc4057, 
        A_DOUT(7) => nc3037, A_DOUT(6) => nc65, A_DOUT(5) => 
        nc3248, A_DOUT(4) => nc1158, A_DOUT(3) => nc1657, 
        A_DOUT(2) => nc979, A_DOUT(1) => nc2887, A_DOUT(0) => 
        \R_DATA_TEMPR0[18]\, B_DOUT(19) => nc2057, B_DOUT(18) => 
        nc5986, B_DOUT(17) => nc5901, B_DOUT(16) => nc5836, 
        B_DOUT(15) => nc178, B_DOUT(14) => nc6021, B_DOUT(13) => 
        nc5414, B_DOUT(12) => nc3896, B_DOUT(11) => nc3166, 
        B_DOUT(10) => nc480, B_DOUT(9) => nc403, B_DOUT(8) => 
        nc5941, B_DOUT(7) => nc1575, B_DOUT(6) => nc3862, 
        B_DOUT(5) => nc2266, B_DOUT(4) => nc2228, B_DOUT(3) => 
        nc3865, B_DOUT(2) => nc2543, B_DOUT(1) => nc857, 
        B_DOUT(0) => nc5511, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][18]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(18), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C22 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%22%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc247, A_DOUT(18) => nc6065, 
        A_DOUT(17) => nc122, A_DOUT(16) => nc2942, A_DOUT(15) => 
        nc3584, A_DOUT(14) => nc327, A_DOUT(13) => nc613, 
        A_DOUT(12) => nc2213, A_DOUT(11) => nc5838, A_DOUT(10)
         => nc5594, A_DOUT(9) => nc1953, A_DOUT(8) => nc4598, 
        A_DOUT(7) => nc3898, A_DOUT(6) => nc913, A_DOUT(5) => 
        nc4658, A_DOUT(4) => nc3638, A_DOUT(3) => nc1209, 
        A_DOUT(2) => nc206, A_DOUT(1) => nc5751, A_DOUT(0) => 
        \R_DATA_TEMPR2[22]\, B_DOUT(19) => nc1859, B_DOUT(18) => 
        nc911, B_DOUT(17) => nc689, B_DOUT(16) => nc5479, 
        B_DOUT(15) => nc954, B_DOUT(14) => nc233, B_DOUT(13) => 
        nc6109, B_DOUT(12) => nc4199, B_DOUT(11) => nc5730, 
        B_DOUT(10) => nc2658, B_DOUT(9) => nc4640, B_DOUT(8) => 
        nc4303, B_DOUT(7) => nc3790, B_DOUT(6) => nc3001, 
        B_DOUT(5) => nc2217, B_DOUT(4) => nc5476, B_DOUT(3) => 
        nc4250, B_DOUT(2) => nc3230, B_DOUT(1) => nc902, 
        B_DOUT(0) => nc3454, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][22]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(22), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C25 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%25%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1012, A_DOUT(18) => nc581, 
        A_DOUT(17) => nc144, A_DOUT(16) => nc872, A_DOUT(15) => 
        nc2250, A_DOUT(14) => nc4081, A_DOUT(13) => nc450, 
        A_DOUT(12) => nc4915, A_DOUT(11) => nc4634, A_DOUT(10)
         => nc6024, A_DOUT(9) => nc3551, A_DOUT(8) => nc3981, 
        A_DOUT(7) => nc3767, A_DOUT(6) => nc3515, A_DOUT(5) => 
        nc2087, A_DOUT(4) => nc5991, A_DOUT(3) => nc4464, 
        A_DOUT(2) => nc3424, A_DOUT(1) => nc1999, A_DOUT(0) => 
        \R_DATA_TEMPR2[25]\, B_DOUT(19) => nc4058, B_DOUT(18) => 
        nc3038, B_DOUT(17) => nc61, B_DOUT(16) => nc5176, 
        B_DOUT(15) => nc5789, B_DOUT(14) => nc3907, B_DOUT(13)
         => nc2647, B_DOUT(12) => nc2148, B_DOUT(11) => nc1236, 
        B_DOUT(10) => nc5872, B_DOUT(9) => nc5875, B_DOUT(8) => 
        nc4622, B_DOUT(7) => nc4561, B_DOUT(6) => nc3521, 
        B_DOUT(5) => nc2058, B_DOUT(4) => nc2392, B_DOUT(3) => 
        nc4045, B_DOUT(2) => nc2664, B_DOUT(1) => nc4987, 
        B_DOUT(0) => nc659, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][25]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(25), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C27 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%27%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5834, A_DOUT(18) => nc5313, 
        A_DOUT(17) => nc44, A_DOUT(16) => nc838, A_DOUT(15) => 
        nc1409, A_DOUT(14) => nc3894, A_DOUT(13) => nc605, 
        A_DOUT(12) => nc1517, A_DOUT(11) => nc385, A_DOUT(10) => 
        nc2402, A_DOUT(9) => nc103, A_DOUT(8) => nc817, A_DOUT(7)
         => nc462, A_DOUT(6) => nc2072, A_DOUT(5) => nc1406, 
        A_DOUT(4) => nc3004, A_DOUT(3) => nc4317, A_DOUT(2) => 
        nc551, A_DOUT(1) => nc1473, A_DOUT(0) => 
        \R_DATA_TEMPR3[27]\, B_DOUT(19) => nc886, B_DOUT(18) => 
        nc4478, B_DOUT(17) => nc2943, B_DOUT(16) => nc2688, 
        B_DOUT(15) => nc1572, B_DOUT(14) => nc6148, B_DOUT(13)
         => nc5934, B_DOUT(12) => nc2849, B_DOUT(11) => nc2231, 
        B_DOUT(10) => nc6162, B_DOUT(9) => nc4084, B_DOUT(8) => 
        nc486, B_DOUT(7) => nc382, B_DOUT(6) => nc3994, B_DOUT(5)
         => nc914, B_DOUT(4) => nc1724, B_DOUT(3) => nc5422, 
        B_DOUT(2) => nc3774, B_DOUT(1) => nc841, B_DOUT(0) => 
        nc2280, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][27]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(27), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C4 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%4%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5288, A_DOUT(18) => nc1106, 
        A_DOUT(17) => nc1715, A_DOUT(16) => nc5000, A_DOUT(15)
         => nc5777, A_DOUT(14) => nc1802, A_DOUT(13) => nc3369, 
        A_DOUT(12) => nc1042, A_DOUT(11) => nc2033, A_DOUT(10)
         => nc1805, A_DOUT(9) => nc3353, A_DOUT(8) => nc5040, 
        A_DOUT(7) => nc2197, A_DOUT(6) => nc410, A_DOUT(5) => 
        nc1320, A_DOUT(4) => nc5768, A_DOUT(3) => nc2577, 
        A_DOUT(2) => nc88, A_DOUT(1) => nc4811, A_DOUT(0) => 
        \R_DATA_TEMPR1[4]\, B_DOUT(19) => nc3370, B_DOUT(18) => 
        nc672, B_DOUT(17) => nc2088, B_DOUT(16) => nc355, 
        B_DOUT(15) => nc1634, B_DOUT(14) => nc4363, B_DOUT(13)
         => nc3323, B_DOUT(12) => nc1482, B_DOUT(11) => nc525, 
        B_DOUT(10) => nc6134, B_DOUT(9) => nc2716, B_DOUT(8) => 
        nc856, B_DOUT(7) => nc4939, B_DOUT(6) => nc4900, 
        B_DOUT(5) => nc3413, B_DOUT(4) => nc4111, B_DOUT(3) => 
        nc4376, B_DOUT(2) => nc5703, B_DOUT(1) => nc985, 
        B_DOUT(0) => nc1526, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][4]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(4), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C20 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%20%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2193, A_DOUT(18) => nc2190, 
        A_DOUT(17) => nc3576, A_DOUT(16) => nc3512, A_DOUT(15)
         => nc4405, A_DOUT(14) => nc195, A_DOUT(13) => nc1059, 
        A_DOUT(12) => nc5338, A_DOUT(11) => nc456, A_DOUT(10) => 
        nc352, A_DOUT(9) => nc5743, A_DOUT(8) => nc2837, 
        A_DOUT(7) => nc2813, A_DOUT(6) => nc619, A_DOUT(5) => 
        nc3398, A_DOUT(4) => nc2294, A_DOUT(3) => nc2497, 
        A_DOUT(2) => nc2295, A_DOUT(1) => nc2775, A_DOUT(0) => 
        \R_DATA_TEMPR3[20]\, B_DOUT(19) => nc1547, B_DOUT(18) => 
        nc4142, B_DOUT(17) => nc3262, B_DOUT(16) => nc5569, 
        B_DOUT(15) => nc6036, B_DOUT(14) => nc2969, B_DOUT(13)
         => nc1707, B_DOUT(12) => nc511, B_DOUT(11) => nc1610, 
        B_DOUT(10) => nc370, B_DOUT(9) => nc4051, B_DOUT(8) => 
        nc3080, B_DOUT(7) => nc3031, B_DOUT(6) => nc4401, 
        B_DOUT(5) => nc5090, B_DOUT(4) => nc85, B_DOUT(3) => 
        nc4816, B_DOUT(2) => nc647, B_DOUT(1) => nc5379, 
        B_DOUT(0) => nc3968, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][20]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(20), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C34 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%34%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2051, A_DOUT(18) => nc1474, 
        A_DOUT(17) => nc478, A_DOUT(16) => nc5910, A_DOUT(15) => 
        nc4675, A_DOUT(14) => nc1745, A_DOUT(13) => nc5415, 
        A_DOUT(12) => nc4341, A_DOUT(11) => nc1571, A_DOUT(10)
         => nc955, A_DOUT(9) => nc22, A_DOUT(8) => nc4957, 
        A_DOUT(7) => nc3937, A_DOUT(6) => nc4818, A_DOUT(5) => 
        nc3783, A_DOUT(4) => nc1125, A_DOUT(3) => nc3175, 
        A_DOUT(2) => nc1768, A_DOUT(1) => nc5793, A_DOUT(0) => 
        \R_DATA_TEMPR3[34]\, B_DOUT(19) => nc3945, B_DOUT(18) => 
        nc1015, B_DOUT(17) => nc3762, B_DOUT(16) => nc2957, 
        B_DOUT(15) => nc315, B_DOUT(14) => nc2670, B_DOUT(13) => 
        nc4710, B_DOUT(12) => nc5411, B_DOUT(11) => nc816, 
        B_DOUT(10) => nc2037, B_DOUT(9) => nc5966, B_DOUT(8) => 
        nc5233, B_DOUT(7) => nc3293, B_DOUT(6) => nc6118, 
        B_DOUT(5) => nc4374, B_DOUT(4) => nc5272, B_DOUT(3) => 
        nc294, B_DOUT(2) => nc2049, B_DOUT(1) => nc3950, 
        B_DOUT(0) => nc2925, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][34]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(34), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C33 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%33%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1939, A_DOUT(18) => nc187, 
        A_DOUT(17) => nc5505, A_DOUT(16) => nc4054, A_DOUT(15)
         => nc3034, A_DOUT(14) => nc416, A_DOUT(13) => nc312, 
        A_DOUT(12) => nc1309, A_DOUT(11) => nc241, A_DOUT(10) => 
        nc5754, A_DOUT(9) => nc5545, A_DOUT(8) => nc3414, 
        A_DOUT(7) => nc3455, A_DOUT(6) => nc2054, A_DOUT(5) => 
        nc5237, A_DOUT(4) => nc3297, A_DOUT(3) => nc1569, 
        A_DOUT(2) => nc5978, A_DOUT(1) => nc4960, A_DOUT(0) => 
        \R_DATA_TEMPR1[33]\, B_DOUT(19) => nc3920, B_DOUT(18) => 
        nc2692, B_DOUT(17) => nc3511, B_DOUT(16) => nc2081, 
        B_DOUT(15) => nc1640, B_DOUT(14) => nc1554, B_DOUT(13)
         => nc4104, B_DOUT(12) => nc3347, B_DOUT(11) => nc5350, 
        B_DOUT(10) => nc4465, B_DOUT(9) => nc3425, B_DOUT(8) => 
        nc81, B_DOUT(7) => nc6072, B_DOUT(6) => nc920, B_DOUT(5)
         => nc2075, B_DOUT(4) => nc1325, B_DOUT(3) => nc3375, 
        B_DOUT(2) => nc2638, B_DOUT(1) => nc6049, B_DOUT(0) => 
        nc3451, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][33]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(33), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C8 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%8%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc694, A_DOUT(18) => nc4814, 
        A_DOUT(17) => nc269, A_DOUT(16) => nc1373, A_DOUT(15) => 
        nc4791, A_DOUT(14) => nc2327, A_DOUT(13) => nc4249, 
        A_DOUT(12) => nc2230, A_DOUT(11) => nc5772, A_DOUT(10)
         => nc5556, A_DOUT(9) => nc915, A_DOUT(8) => nc2987, 
        A_DOUT(7) => nc4006, A_DOUT(6) => nc157, A_DOUT(5) => 
        nc1202, A_DOUT(4) => nc6194, A_DOUT(3) => nc4461, 
        A_DOUT(2) => nc3421, A_DOUT(1) => nc1623, A_DOUT(0) => 
        \R_DATA_TEMPR1[8]\, B_DOUT(19) => nc381, B_DOUT(18) => 
        nc4428, B_DOUT(17) => nc3673, B_DOUT(16) => nc4914, 
        B_DOUT(15) => nc3585, B_DOUT(14) => nc1629, B_DOUT(13)
         => nc3841, B_DOUT(12) => nc3679, B_DOUT(11) => nc1951, 
        B_DOUT(10) => nc1045, B_DOUT(9) => nc5769, B_DOUT(8) => 
        nc5595, B_DOUT(7) => nc5114, B_DOUT(6) => nc6166, 
        B_DOUT(5) => nc1908, B_DOUT(4) => nc2038, B_DOUT(3) => 
        nc3266, B_DOUT(2) => nc1112, B_DOUT(1) => nc1966, 
        B_DOUT(0) => nc2084, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][8]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(8), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C7 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%7%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3141, A_DOUT(18) => nc6096, 
        A_DOUT(17) => nc2821, A_DOUT(16) => nc2012, A_DOUT(15)
         => nc475, A_DOUT(14) => nc373, A_DOUT(13) => nc1392, 
        A_DOUT(12) => nc1621, A_DOUT(11) => nc3402, A_DOUT(10)
         => nc3671, A_DOUT(9) => nc3313, A_DOUT(8) => nc5403, 
        A_DOUT(7) => nc306, A_DOUT(6) => nc275, A_DOUT(5) => 
        nc5016, A_DOUT(4) => nc2121, A_DOUT(3) => nc5502, 
        A_DOUT(2) => nc5443, A_DOUT(1) => nc4449, A_DOUT(0) => 
        \R_DATA_TEMPR1[7]\, B_DOUT(19) => nc1702, B_DOUT(18) => 
        nc4482, B_DOUT(17) => nc2544, B_DOUT(16) => nc351, 
        B_DOUT(15) => nc4326, B_DOUT(14) => nc5542, B_DOUT(13)
         => nc1311, B_DOUT(12) => nc633, B_DOUT(11) => nc5155, 
        B_DOUT(10) => nc4446, B_DOUT(9) => nc5985, B_DOUT(8) => 
        nc2708, B_DOUT(7) => nc4318, B_DOUT(6) => nc3154, 
        B_DOUT(5) => nc933, B_DOUT(4) => nc5268, B_DOUT(3) => 
        nc3846, B_DOUT(2) => nc931, B_DOUT(1) => nc4800, 
        B_DOUT(0) => nc5736, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][7]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(7), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C12 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%12%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4570, A_DOUT(18) => nc2172, 
        A_DOUT(17) => nc3796, A_DOUT(16) => nc2517, A_DOUT(15)
         => nc4164, A_DOUT(14) => nc3124, A_DOUT(13) => nc117, 
        A_DOUT(12) => nc5833, A_DOUT(11) => nc4146, A_DOUT(10)
         => nc2826, A_DOUT(9) => nc864, A_DOUT(8) => nc809, 
        A_DOUT(7) => nc5728, A_DOUT(6) => nc3893, A_DOUT(5) => 
        nc5276, A_DOUT(4) => nc1197, A_DOUT(3) => nc4842, 
        A_DOUT(2) => nc3056, A_DOUT(1) => nc3848, A_DOUT(0) => 
        \R_DATA_TEMPR0[12]\, B_DOUT(19) => nc4845, B_DOUT(18) => 
        nc2941, B_DOUT(17) => nc4470, B_DOUT(16) => nc3, 
        B_DOUT(15) => nc3664, B_DOUT(14) => nc1769, B_DOUT(13)
         => nc1970, B_DOUT(12) => nc4625, B_DOUT(11) => nc2509, 
        B_DOUT(10) => nc5387, B_DOUT(9) => nc3483, B_DOUT(8) => 
        nc63, B_DOUT(7) => nc2371, B_DOUT(6) => nc3740, B_DOUT(5)
         => nc429, B_DOUT(4) => nc620, B_DOUT(3) => nc1142, 
        B_DOUT(2) => nc5493, B_DOUT(1) => nc1475, B_DOUT(0) => 
        nc4066, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][12]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(12), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C21 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%21%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3026, A_DOUT(18) => nc2828, 
        A_DOUT(17) => nc507, A_DOUT(16) => nc3582, A_DOUT(15) => 
        nc2715, A_DOUT(14) => nc5355, A_DOUT(13) => nc278, 
        A_DOUT(12) => nc5810, A_DOUT(11) => nc6019, A_DOUT(10)
         => nc5592, A_DOUT(9) => nc691, A_DOUT(8) => nc1193, 
        A_DOUT(7) => nc1190, A_DOUT(6) => nc1788, A_DOUT(5) => 
        nc4332, A_DOUT(4) => nc2720, A_DOUT(3) => nc1294, 
        A_DOUT(2) => nc5529, A_DOUT(1) => nc1497, A_DOUT(0) => 
        \R_DATA_TEMPR0[21]\, B_DOUT(19) => nc1295, B_DOUT(18) => 
        nc837, B_DOUT(17) => nc6231, B_DOUT(16) => nc1471, 
        B_DOUT(15) => nc5653, B_DOUT(14) => nc4213, B_DOUT(13)
         => nc1219, B_DOUT(12) => nc311, B_DOUT(11) => nc1050, 
        B_DOUT(10) => nc5404, B_DOUT(9) => nc1341, B_DOUT(8) => 
        nc2031, B_DOUT(7) => nc4324, B_DOUT(6) => nc1206, 
        B_DOUT(5) => nc5881, B_DOUT(4) => nc5659, B_DOUT(3) => 
        nc4747, B_DOUT(2) => nc5444, B_DOUT(1) => nc1268, 
        B_DOUT(0) => nc2362, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][21]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(21), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[34]\ : OR4
      port map(A => \R_DATA_TEMPR0[34]\, B => \R_DATA_TEMPR1[34]\, 
        C => \R_DATA_TEMPR2[34]\, D => \R_DATA_TEMPR3[34]\, Y => 
        R_DATA(34));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C14 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%14%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc6033, A_DOUT(18) => nc5501, 
        A_DOUT(17) => nc934, A_DOUT(16) => nc3910, A_DOUT(15) => 
        nc3844, A_DOUT(14) => nc4217, A_DOUT(13) => nc1589, 
        A_DOUT(12) => nc6075, A_DOUT(11) => nc5541, A_DOUT(10)
         => nc2906, A_DOUT(9) => nc5181, A_DOUT(8) => nc3850, 
        A_DOUT(7) => nc5674, A_DOUT(6) => nc3415, A_DOUT(5) => 
        nc885, A_DOUT(4) => nc100, A_DOUT(3) => nc543, A_DOUT(2)
         => nc2937, A_DOUT(1) => nc2610, A_DOUT(0) => 
        \R_DATA_TEMPR3[14]\, B_DOUT(19) => nc5651, B_DOUT(18) => 
        nc2824, B_DOUT(17) => nc349, B_DOUT(16) => nc1753, 
        B_DOUT(15) => nc430, B_DOUT(14) => nc4137, B_DOUT(13) => 
        nc4860, B_DOUT(12) => nc3944, B_DOUT(11) => nc3820, 
        B_DOUT(10) => nc2279, B_DOUT(9) => nc5926, B_DOUT(8) => 
        nc4452, B_DOUT(7) => nc3432, B_DOUT(6) => nc580, 
        B_DOUT(5) => nc747, B_DOUT(4) => nc3411, B_DOUT(3) => 
        nc2498, B_DOUT(2) => nc3969, B_DOUT(1) => nc584, 
        B_DOUT(0) => nc2452, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][14]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(14), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C15 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%15%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1419, A_DOUT(18) => nc2924, 
        A_DOUT(17) => nc1523, A_DOUT(16) => nc2034, A_DOUT(15)
         => nc5886, A_DOUT(14) => nc3573, A_DOUT(13) => nc3484, 
        A_DOUT(12) => nc1416, A_DOUT(11) => nc2167, A_DOUT(10)
         => nc639, A_DOUT(9) => nc4133, A_DOUT(8) => nc4130, 
        A_DOUT(7) => nc1922, A_DOUT(6) => nc5494, A_DOUT(5) => 
        nc3972, A_DOUT(4) => nc4794, A_DOUT(3) => nc4349, 
        A_DOUT(2) => nc4234, A_DOUT(1) => nc4437, A_DOUT(0) => 
        \R_DATA_TEMPR0[15]\, B_DOUT(19) => nc3581, B_DOUT(18) => 
        nc2015, B_DOUT(17) => nc4235, B_DOUT(16) => nc1332, 
        B_DOUT(15) => nc1986, B_DOUT(14) => nc1174, B_DOUT(13)
         => nc855, B_DOUT(12) => nc1604, B_DOUT(11) => nc5591, 
        B_DOUT(10) => nc36, B_DOUT(9) => nc1249, B_DOUT(8) => 
        nc1692, B_DOUT(7) => nc531, B_DOUT(6) => nc2040, 
        B_DOUT(5) => nc5888, B_DOUT(4) => nc5303, B_DOUT(3) => 
        nc775, B_DOUT(2) => nc4390, B_DOUT(1) => nc863, B_DOUT(0)
         => nc1116, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][15]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(15), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[14]\ : OR4
      port map(A => \R_DATA_TEMPR0[14]\, B => \R_DATA_TEMPR1[14]\, 
        C => \R_DATA_TEMPR2[14]\, D => \R_DATA_TEMPR3[14]\, Y => 
        R_DATA(14));
    
    \OR4_R_DATA[33]\ : OR4
      port map(A => \R_DATA_TEMPR0[33]\, B => \R_DATA_TEMPR1[33]\, 
        C => \R_DATA_TEMPR2[33]\, D => \R_DATA_TEMPR3[33]\, Y => 
        R_DATA(33));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C18 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%18%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2163, A_DOUT(18) => nc2160, 
        A_DOUT(17) => nc5343, A_DOUT(16) => nc3348, A_DOUT(15)
         => nc4676, A_DOUT(14) => nc2709, A_DOUT(13) => nc1812, 
        A_DOUT(12) => nc169, A_DOUT(11) => nc1815, A_DOUT(10) => 
        nc5780, A_DOUT(9) => nc550, A_DOUT(8) => nc2264, 
        A_DOUT(7) => nc2467, A_DOUT(6) => nc998, A_DOUT(5) => 
        nc2265, A_DOUT(4) => nc2396, A_DOUT(3) => nc1076, 
        A_DOUT(2) => nc2479, A_DOUT(1) => nc554, A_DOUT(0) => 
        \R_DATA_TEMPR2[18]\, B_DOUT(19) => nc5032, B_DOUT(18) => 
        nc388, B_DOUT(17) => nc4596, B_DOUT(16) => nc4201, 
        B_DOUT(15) => nc2328, B_DOUT(14) => nc3092, B_DOUT(13)
         => nc2476, B_DOUT(12) => nc6172, B_DOUT(11) => nc2743, 
        B_DOUT(10) => nc589, B_DOUT(9) => nc6040, B_DOUT(8) => 
        nc6037, B_DOUT(7) => nc1128, B_DOUT(6) => nc1627, 
        B_DOUT(5) => nc3677, B_DOUT(4) => nc3178, B_DOUT(3) => 
        nc1555, B_DOUT(2) => nc5979, B_DOUT(1) => nc5729, 
        B_DOUT(0) => nc4242, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][18]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(18), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C39 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%39%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc763, A_DOUT(18) => nc6157, 
        A_DOUT(17) => nc2482, A_DOUT(16) => nc335, A_DOUT(15) => 
        nc4716, A_DOUT(14) => nc4520, A_DOUT(13) => nc1137, 
        A_DOUT(12) => nc4003, A_DOUT(11) => nc3114, A_DOUT(10)
         => nc836, A_DOUT(9) => nc769, A_DOUT(8) => nc1449, 
        A_DOUT(7) => nc2176, A_DOUT(6) => nc4948, A_DOUT(5) => 
        nc4813, A_DOUT(4) => nc2872, A_DOUT(3) => nc436, 
        A_DOUT(2) => nc332, A_DOUT(1) => nc273, A_DOUT(0) => 
        \R_DATA_TEMPR3[39]\, B_DOUT(19) => nc2208, B_DOUT(18) => 
        nc5884, B_DOUT(17) => nc2875, B_DOUT(16) => nc3383, 
        B_DOUT(15) => nc2695, B_DOUT(14) => nc1446, B_DOUT(13)
         => nc1717, B_DOUT(12) => nc1789, B_DOUT(11) => nc6153, 
        B_DOUT(10) => nc6150, B_DOUT(9) => nc5393, B_DOUT(8) => 
        nc4420, B_DOUT(7) => nc1923, B_DOUT(6) => nc5537, 
        B_DOUT(5) => nc3973, B_DOUT(4) => nc5211, B_DOUT(3) => 
        nc1133, B_DOUT(2) => nc1130, B_DOUT(1) => nc3597, 
        B_DOUT(0) => nc1829, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][39]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(39), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C3 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%3%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3016, A_DOUT(18) => nc6093, 
        A_DOUT(17) => nc3879, A_DOUT(16) => nc815, A_DOUT(15) => 
        nc5965, A_DOUT(14) => nc358, A_DOUT(13) => nc3708, 
        A_DOUT(12) => nc1234, A_DOUT(11) => nc1437, A_DOUT(10)
         => nc4807, A_DOUT(9) => nc3243, A_DOUT(8) => nc1235, 
        A_DOUT(7) => nc559, A_DOUT(6) => nc4632, A_DOUT(5) => 
        nc2112, A_DOUT(4) => nc6105, A_DOUT(3) => nc5984, 
        A_DOUT(2) => nc5228, A_DOUT(1) => nc4742, A_DOUT(0) => 
        \R_DATA_TEMPR3[3]\, B_DOUT(19) => nc4195, B_DOUT(18) => 
        nc83, B_DOUT(17) => nc1870, B_DOUT(16) => nc1146, 
        B_DOUT(15) => nc5013, B_DOUT(14) => nc1909, B_DOUT(13)
         => nc6230, B_DOUT(12) => nc4788, B_DOUT(11) => nc1842, 
        B_DOUT(10) => nc1845, B_DOUT(9) => nc510, B_DOUT(8) => 
        nc2223, B_DOUT(7) => nc3247, B_DOUT(6) => nc463, 
        B_DOUT(5) => nc5735, B_DOUT(4) => nc2394, B_DOUT(3) => 
        nc514, B_DOUT(2) => nc3795, B_DOUT(1) => nc5553, 
        B_DOUT(0) => nc935, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][3]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(3), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[13]\ : OR4
      port map(A => \R_DATA_TEMPR0[13]\, B => \R_DATA_TEMPR1[13]\, 
        C => \R_DATA_TEMPR2[13]\, D => \R_DATA_TEMPR3[13]\, Y => 
        R_DATA(13));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C9 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%9%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2662, A_DOUT(18) => nc878, 
        A_DOUT(17) => nc2777, A_DOUT(16) => nc5952, A_DOUT(15)
         => nc5900, A_DOUT(14) => nc6038, A_DOUT(13) => nc2545, 
        A_DOUT(12) => nc3251, A_DOUT(11) => nc1288, A_DOUT(10)
         => nc2311, A_DOUT(9) => nc3509, A_DOUT(8) => nc2227, 
        A_DOUT(7) => nc5367, A_DOUT(6) => nc5940, A_DOUT(5) => 
        nc5405, A_DOUT(4) => nc5817, A_DOUT(3) => nc266, 
        A_DOUT(2) => nc4578, A_DOUT(1) => nc14, A_DOUT(0) => 
        \R_DATA_TEMPR3[9]\, B_DOUT(19) => nc1453, B_DOUT(18) => 
        nc840, B_DOUT(17) => nc5445, B_DOUT(16) => nc4589, 
        B_DOUT(15) => nc1319, B_DOUT(14) => nc606, B_DOUT(13) => 
        nc4261, B_DOUT(12) => nc3221, B_DOUT(11) => nc3053, 
        B_DOUT(10) => nc1552, B_DOUT(9) => nc4179, B_DOUT(8) => 
        nc5388, B_DOUT(7) => nc441, B_DOUT(6) => nc962, B_DOUT(5)
         => nc4395, B_DOUT(4) => nc3810, B_DOUT(3) => nc99, 
        B_DOUT(2) => nc1747, B_DOUT(1) => nc5401, B_DOUT(0) => 
        nc4007, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][9]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(9), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[35]\ : OR4
      port map(A => \R_DATA_TEMPR0[35]\, B => \R_DATA_TEMPR1[35]\, 
        C => \R_DATA_TEMPR2[35]\, D => \R_DATA_TEMPR3[35]\, Y => 
        R_DATA(35));
    
    \OR4_R_DATA[15]\ : OR4
      port map(A => \R_DATA_TEMPR0[15]\, B => \R_DATA_TEMPR1[15]\, 
        C => \R_DATA_TEMPR2[15]\, D => \R_DATA_TEMPR3[15]\, Y => 
        R_DATA(15));
    
    \OR4_R_DATA[27]\ : OR4
      port map(A => \R_DATA_TEMPR0[27]\, B => \R_DATA_TEMPR1[27]\, 
        C => \R_DATA_TEMPR2[27]\, D => \R_DATA_TEMPR3[27]\, Y => 
        R_DATA(27));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C23 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%23%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4063, A_DOUT(18) => nc3023, 
        A_DOUT(17) => nc5441, A_DOUT(16) => nc318, A_DOUT(15) => 
        nc5861, A_DOUT(14) => nc5630, A_DOUT(13) => nc1965, 
        A_DOUT(12) => nc519, A_DOUT(11) => nc6010, A_DOUT(10) => 
        nc4693, A_DOUT(9) => nc3690, A_DOUT(8) => nc5657, 
        A_DOUT(7) => nc5158, A_DOUT(6) => nc3857, A_DOUT(5) => 
        nc4699, A_DOUT(4) => nc1632, A_DOUT(3) => nc5161, 
        A_DOUT(2) => nc3980, A_DOUT(1) => nc3906, A_DOUT(0) => 
        \R_DATA_TEMPR3[23]\, B_DOUT(19) => nc4246, B_DOUT(18) => 
        nc6097, B_DOUT(17) => nc5990, B_DOUT(16) => nc1212, 
        B_DOUT(15) => nc2379, B_DOUT(14) => nc3485, B_DOUT(13)
         => nc665, B_DOUT(12) => nc5495, B_DOUT(11) => nc4986, 
        B_DOUT(10) => nc4867, B_DOUT(9) => nc3827, B_DOUT(8) => 
        nc163, B_DOUT(7) => nc137, B_DOUT(6) => nc4608, B_DOUT(5)
         => nc728, B_DOUT(4) => nc5017, B_DOUT(3) => nc2219, 
        B_DOUT(2) => nc404, B_DOUT(1) => nc5953, B_DOUT(0) => 
        nc4691, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][23]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(23), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C19 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%19%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1918, A_DOUT(18) => nc5035, 
        A_DOUT(17) => nc192, A_DOUT(16) => nc1029, A_DOUT(15) => 
        nc1367, A_DOUT(14) => nc5859, A_DOUT(13) => nc4626, 
        A_DOUT(12) => nc3079, A_DOUT(11) => nc397, A_DOUT(10) => 
        nc4200, A_DOUT(9) => nc3095, A_DOUT(8) => nc2443, 
        A_DOUT(7) => nc2432, A_DOUT(6) => nc3746, A_DOUT(5) => 
        nc3481, A_DOUT(4) => nc5283, A_DOUT(3) => nc5866, 
        A_DOUT(2) => nc5491, A_DOUT(1) => nc2542, A_DOUT(0) => 
        \R_DATA_TEMPR3[19]\, B_DOUT(19) => nc1349, B_DOUT(18) => 
        nc1498, B_DOUT(17) => nc4012, B_DOUT(16) => nc4758, 
        B_DOUT(15) => nc3843, B_DOUT(14) => nc3738, B_DOUT(13)
         => nc1454, B_DOUT(12) => nc2590, B_DOUT(11) => nc2272, 
        B_DOUT(10) => nc5104, B_DOUT(9) => nc2726, B_DOUT(8) => 
        nc1712, B_DOUT(7) => nc5287, B_DOUT(6) => nc4008, 
        B_DOUT(5) => nc6176, B_DOUT(4) => nc6031, B_DOUT(3) => 
        nc2758, B_DOUT(2) => nc5144, B_DOUT(1) => nc3362, 
        B_DOUT(0) => nc5618, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][19]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(19), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C1 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%1%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1551, A_DOUT(18) => nc5868, 
        A_DOUT(17) => nc3057, A_DOUT(16) => nc2823, A_DOUT(15)
         => nc1861, A_DOUT(14) => nc331, A_DOUT(13) => nc2978, 
        A_DOUT(12) => nc3709, A_DOUT(11) => nc5210, A_DOUT(10)
         => nc4644, A_DOUT(9) => nc2490, A_DOUT(8) => nc5760, 
        A_DOUT(7) => nc2419, A_DOUT(6) => nc5006, A_DOUT(5) => 
        nc4067, A_DOUT(4) => nc3027, A_DOUT(3) => nc1161, 
        A_DOUT(2) => nc6228, A_DOUT(1) => nc6098, A_DOUT(0) => 
        \R_DATA_TEMPR3[1]\, B_DOUT(19) => nc2416, B_DOUT(18) => 
        nc1242, B_DOUT(17) => nc5046, B_DOUT(16) => nc4789, 
        B_DOUT(15) => nc4559, B_DOUT(14) => nc4517, B_DOUT(13)
         => nc3539, B_DOUT(12) => nc1271, B_DOUT(11) => nc1396, 
        B_DOUT(10) => nc185, B_DOUT(9) => nc2559, B_DOUT(8) => 
        nc5018, B_DOUT(7) => nc6181, B_DOUT(6) => nc2772, 
        B_DOUT(5) => nc3658, B_DOUT(4) => nc1948, B_DOUT(3) => 
        nc1073, B_DOUT(2) => nc3167, B_DOUT(1) => nc2116, 
        B_DOUT(0) => nc3184, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][1]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(1), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C26 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%26%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc6034, A_DOUT(18) => nc2812, 
        A_DOUT(17) => nc5194, A_DOUT(16) => nc2905, A_DOUT(15)
         => nc2815, A_DOUT(14) => nc4715, A_DOUT(13) => nc3250, 
        A_DOUT(12) => nc5132, A_DOUT(11) => nc927, A_DOUT(10) => 
        nc1866, A_DOUT(9) => nc5864, A_DOUT(8) => nc4668, 
        A_DOUT(7) => nc3628, A_DOUT(6) => nc3208, A_DOUT(5) => 
        nc3192, A_DOUT(4) => nc5372, A_DOUT(3) => nc2788, 
        A_DOUT(2) => nc4438, A_DOUT(1) => nc2444, A_DOUT(0) => 
        \R_DATA_TEMPR0[26]\, B_DOUT(19) => nc1524, B_DOUT(18) => 
        nc344, B_DOUT(17) => nc1353, B_DOUT(16) => nc3574, 
        B_DOUT(15) => nc1742, B_DOUT(14) => nc4288, B_DOUT(13)
         => nc1695, B_DOUT(12) => nc4260, B_DOUT(11) => nc3220, 
        B_DOUT(10) => nc3163, B_DOUT(9) => nc3160, B_DOUT(8) => 
        nc2541, B_DOUT(7) => nc3086, B_DOUT(6) => nc5925, 
        B_DOUT(5) => nc3211, B_DOUT(4) => nc3058, B_DOUT(3) => 
        nc1216, B_DOUT(2) => nc5096, B_DOUT(1) => nc4956, 
        B_DOUT(0) => nc3936, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][26]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(26), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C12 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%12%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1868, A_DOUT(18) => nc1877, 
        A_DOUT(17) => nc4528, A_DOUT(16) => nc3264, A_DOUT(15)
         => nc155, A_DOUT(14) => nc5964, A_DOUT(13) => nc5800, 
        A_DOUT(12) => nc3467, A_DOUT(11) => nc3265, A_DOUT(10)
         => nc242, A_DOUT(9) => nc5331, A_DOUT(8) => nc2468, 
        A_DOUT(7) => nc2956, A_DOUT(6) => nc5840, A_DOUT(5) => 
        nc4129, A_DOUT(4) => nc3391, A_DOUT(3) => nc5059, 
        A_DOUT(2) => nc595, A_DOUT(1) => nc1760, A_DOUT(0) => 
        \R_DATA_TEMPR2[12]\, B_DOUT(19) => nc2307, B_DOUT(18) => 
        nc4068, B_DOUT(17) => nc3028, B_DOUT(16) => nc3013, 
        B_DOUT(15) => nc2589, B_DOUT(14) => nc5786, B_DOUT(13)
         => nc101, B_DOUT(12) => nc2717, B_DOUT(11) => nc4949, 
        B_DOUT(10) => nc1921, B_DOUT(9) => nc4001, B_DOUT(8) => 
        nc1985, B_DOUT(7) => nc3971, B_DOUT(6) => nc284, 
        B_DOUT(5) => nc5177, B_DOUT(4) => nc1394, B_DOUT(3) => 
        nc5883, B_DOUT(2) => nc4610, B_DOUT(1) => nc1302, 
        B_DOUT(0) => nc4336, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][12]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(12), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C15 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%15%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4593, A_DOUT(18) => nc5327, 
        A_DOUT(17) => nc4992, A_DOUT(16) => nc2276, A_DOUT(15)
         => nc3817, A_DOUT(14) => nc2801, A_DOUT(13) => nc673, 
        A_DOUT(12) => nc5368, A_DOUT(11) => nc6091, A_DOUT(10)
         => nc4907, A_DOUT(9) => nc5173, A_DOUT(8) => nc5170, 
        A_DOUT(7) => nc2366, A_DOUT(6) => nc4771, A_DOUT(5) => 
        nc1864, A_DOUT(4) => nc973, A_DOUT(3) => nc3880, 
        A_DOUT(2) => nc3042, A_DOUT(1) => nc971, A_DOUT(0) => 
        \R_DATA_TEMPR2[15]\, B_DOUT(19) => nc684, B_DOUT(18) => 
        nc2343, B_DOUT(17) => nc5274, B_DOUT(16) => nc2696, 
        B_DOUT(15) => nc207, B_DOUT(14) => nc1077, B_DOUT(13) => 
        nc5890, B_DOUT(12) => nc5477, B_DOUT(11) => nc5275, 
        B_DOUT(10) => nc2101, B_DOUT(9) => nc1387, B_DOUT(8) => 
        nc1438, B_DOUT(7) => nc5011, B_DOUT(6) => nc1614, 
        B_DOUT(5) => nc4759, B_DOUT(4) => nc3739, B_DOUT(3) => 
        nc4015, B_DOUT(2) => nc2986, B_DOUT(1) => nc29, B_DOUT(0)
         => nc4635, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][15]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(15), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[32]\ : OR4
      port map(A => \R_DATA_TEMPR0[32]\, B => \R_DATA_TEMPR1[32]\, 
        C => \R_DATA_TEMPR2[32]\, D => \R_DATA_TEMPR3[32]\, Y => 
        R_DATA(32));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C11 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%11%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5821, A_DOUT(18) => nc1246, 
        A_DOUT(17) => nc254, A_DOUT(16) => nc2759, A_DOUT(15) => 
        nc835, A_DOUT(14) => nc2022, A_DOUT(13) => nc115, 
        A_DOUT(12) => nc4004, A_DOUT(11) => nc1107, A_DOUT(10)
         => nc5239, A_DOUT(9) => nc1964, A_DOUT(8) => nc3299, 
        A_DOUT(7) => nc2319, A_DOUT(6) => nc6108, A_DOUT(5) => 
        nc4697, A_DOUT(4) => nc4198, A_DOUT(3) => nc3662, 
        A_DOUT(2) => nc5121, A_DOUT(1) => nc741, A_DOUT(0) => 
        \R_DATA_TEMPR1[11]\, B_DOUT(19) => nc1950, B_DOUT(18) => 
        nc104, B_DOUT(17) => nc67, B_DOUT(16) => nc5917, 
        B_DOUT(15) => nc2665, B_DOUT(14) => nc530, B_DOUT(13) => 
        nc3547, B_DOUT(12) => nc2806, B_DOUT(11) => nc1455, 
        B_DOUT(10) => nc1881, B_DOUT(9) => nc1678, B_DOUT(8) => 
        nc1103, B_DOUT(7) => nc1100, B_DOUT(6) => nc366, 
        B_DOUT(5) => nc534, B_DOUT(4) => nc6094, B_DOUT(3) => 
        nc548, B_DOUT(2) => nc3051, B_DOUT(1) => nc654, B_DOUT(0)
         => nc5554, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][11]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(11), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[12]\ : OR4
      port map(A => \R_DATA_TEMPR0[12]\, B => \R_DATA_TEMPR1[12]\, 
        C => \R_DATA_TEMPR2[12]\, D => \R_DATA_TEMPR3[12]\, Y => 
        R_DATA(12));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C31 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%31%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4334, A_DOUT(18) => nc744, 
        A_DOUT(17) => nc2674, A_DOUT(16) => nc1204, A_DOUT(15)
         => nc3017, A_DOUT(14) => nc946, A_DOUT(13) => nc1407, 
        A_DOUT(12) => nc1205, A_DOUT(11) => nc4258, A_DOUT(10)
         => nc3238, A_DOUT(9) => nc1336, A_DOUT(8) => nc1270, 
        A_DOUT(7) => nc1181, A_DOUT(6) => nc2527, A_DOUT(5) => 
        nc5263, A_DOUT(4) => nc4993, A_DOUT(3) => nc877, 
        A_DOUT(2) => nc5014, A_DOUT(1) => nc4899, A_DOUT(0) => 
        \R_DATA_TEMPR2[31]\, B_DOUT(19) => nc2808, B_DOUT(18) => 
        nc2258, B_DOUT(17) => nc5826, B_DOUT(16) => nc1451, 
        B_DOUT(15) => nc4061, B_DOUT(14) => nc3021, B_DOUT(13)
         => nc990, B_DOUT(12) => nc40, B_DOUT(11) => nc2212, 
        B_DOUT(10) => nc1368, B_DOUT(9) => nc3745, B_DOUT(8) => 
        nc5439, B_DOUT(7) => nc2364, B_DOUT(6) => nc5267, 
        B_DOUT(5) => nc3957, B_DOUT(4) => nc3499, B_DOUT(3) => 
        nc2700, B_DOUT(2) => nc1078, B_DOUT(1) => nc2738, 
        B_DOUT(0) => nc974, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][31]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(31), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[20]\ : OR4
      port map(A => \R_DATA_TEMPR0[20]\, B => \R_DATA_TEMPR1[20]\, 
        C => \R_DATA_TEMPR2[20]\, D => \R_DATA_TEMPR3[20]\, Y => 
        R_DATA(20));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C0 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2789, A_DOUT(18) => nc1020, 
        A_DOUT(17) => nc5436, A_DOUT(16) => nc3070, A_DOUT(15)
         => nc869, A_DOUT(14) => nc1644, A_DOUT(13) => nc3496, 
        A_DOUT(12) => nc1590, A_DOUT(11) => nc5951, A_DOUT(10)
         => nc5828, A_DOUT(9) => nc2918, A_DOUT(8) => nc5672, 
        A_DOUT(7) => nc2725, A_DOUT(6) => nc214, A_DOUT(5) => 
        nc3618, A_DOUT(4) => nc1886, A_DOUT(3) => nc4967, 
        A_DOUT(2) => nc3927, A_DOUT(1) => nc338, A_DOUT(0) => 
        \R_DATA_TEMPR1[0]\, B_DOUT(19) => nc1635, B_DOUT(18) => 
        nc1919, B_DOUT(17) => nc4112, B_DOUT(16) => nc470, 
        B_DOUT(15) => nc722, B_DOUT(14) => nc801, B_DOUT(13) => 
        nc539, B_DOUT(12) => nc5720, B_DOUT(11) => nc3054, 
        B_DOUT(10) => nc567, B_DOUT(9) => nc5136, B_DOUT(8) => 
        nc3210, B_DOUT(7) => nc2940, B_DOUT(6) => nc1490, 
        B_DOUT(5) => nc5201, B_DOUT(4) => nc427, B_DOUT(3) => 
        nc3196, B_DOUT(2) => nc5832, B_DOUT(1) => nc2598, 
        B_DOUT(0) => nc1723, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][0]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(0), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C38 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%38%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5835, A_DOUT(18) => nc3892, 
        A_DOUT(17) => nc3773, A_DOUT(16) => nc5241, A_DOUT(15)
         => nc2539, A_DOUT(14) => nc2445, A_DOUT(13) => nc1888, 
        A_DOUT(12) => nc3895, A_DOUT(11) => nc2712, A_DOUT(10)
         => nc4064, A_DOUT(9) => nc3024, A_DOUT(8) => nc2804, 
        A_DOUT(7) => nc74, A_DOUT(6) => nc2199, A_DOUT(5) => 
        nc5082, A_DOUT(4) => nc681, A_DOUT(3) => nc614, A_DOUT(2)
         => nc5003, A_DOUT(1) => nc679, A_DOUT(0) => 
        \R_DATA_TEMPR0[38]\, B_DOUT(19) => nc3640, B_DOUT(18) => 
        nc2288, B_DOUT(17) => nc4311, B_DOUT(16) => nc3018, 
        B_DOUT(15) => nc1780, B_DOUT(14) => nc5043, B_DOUT(13)
         => nc1334, B_DOUT(12) => nc1263, B_DOUT(11) => nc3905, 
        B_DOUT(10) => nc1602, B_DOUT(9) => nc2441, B_DOUT(8) => 
        nc1154, B_DOUT(7) => nc571, B_DOUT(6) => nc2979, 
        B_DOUT(5) => nc2620, B_DOUT(4) => nc2904, B_DOUT(3) => 
        nc5824, B_DOUT(2) => nc4985, B_DOUT(1) => nc52, B_DOUT(0)
         => nc1267, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][38]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(38), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C21 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%21%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc160, A_DOUT(18) => nc5807, 
        A_DOUT(17) => nc5737, A_DOUT(16) => nc5587, A_DOUT(15)
         => nc3797, A_DOUT(14) => nc1056, A_DOUT(13) => nc4530, 
        A_DOUT(12) => nc3281, A_DOUT(11) => nc5847, A_DOUT(10)
         => nc3045, A_DOUT(9) => nc5924, A_DOUT(8) => nc607, 
        A_DOUT(7) => nc5291, A_DOUT(6) => nc2936, A_DOUT(5) => 
        nc651, A_DOUT(4) => nc1884, A_DOUT(3) => nc1949, 
        A_DOUT(2) => nc4721, A_DOUT(1) => nc3307, A_DOUT(0) => 
        \R_DATA_TEMPR1[21]\, B_DOUT(19) => nc5766, B_DOUT(18) => 
        nc375, B_DOUT(17) => nc3083, B_DOUT(16) => nc2025, 
        B_DOUT(15) => nc6009, B_DOUT(14) => nc4099, B_DOUT(13)
         => nc499, B_DOUT(12) => nc690, B_DOUT(11) => nc5093, 
        B_DOUT(10) => nc4430, B_DOUT(9) => nc4387, B_DOUT(8) => 
        nc876, B_DOUT(7) => nc1071, B_DOUT(6) => nc2560, 
        B_DOUT(5) => nc6121, B_DOUT(4) => nc5863, B_DOUT(3) => 
        nc1525, B_DOUT(2) => nc746, B_DOUT(1) => nc5785, 
        B_DOUT(0) => nc3575, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][21]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(21), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[1]\ : OR4
      port map(A => \R_DATA_TEMPR0[1]\, B => \R_DATA_TEMPR1[1]\, 
        C => \R_DATA_TEMPR2[1]\, D => \R_DATA_TEMPR3[1]\, Y => 
        R_DATA(1));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C9 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%9%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2308, A_DOUT(18) => nc1984, 
        A_DOUT(17) => nc6167, A_DOUT(16) => nc476, A_DOUT(15) => 
        nc372, A_DOUT(14) => nc4774, A_DOUT(13) => nc4219, 
        A_DOUT(12) => nc2216, A_DOUT(11) => nc5050, A_DOUT(10)
         => nc4342, A_DOUT(9) => nc2460, A_DOUT(8) => nc2144, 
        A_DOUT(7) => nc3801, A_DOUT(6) => nc3887, A_DOUT(5) => 
        nc1977, A_DOUT(4) => nc5328, A_DOUT(3) => nc4370, 
        A_DOUT(2) => nc201, A_DOUT(1) => nc5897, A_DOUT(0) => 
        \R_DATA_TEMPR0[9]\, B_DOUT(19) => nc5007, B_DOUT(18) => 
        nc6163, B_DOUT(17) => nc6160, B_DOUT(16) => nc5339, 
        B_DOUT(15) => nc87, B_DOUT(14) => nc4881, B_DOUT(13) => 
        nc3399, B_DOUT(12) => nc3101, B_DOUT(11) => nc1850, 
        B_DOUT(10) => nc5047, B_DOUT(9) => nc3468, B_DOUT(8) => 
        nc5753, B_DOUT(7) => nc1696, B_DOUT(6) => nc4402, 
        B_DOUT(5) => nc988, B_DOUT(4) => nc2739, B_DOUT(3) => 
        nc2046, B_DOUT(2) => nc4576, B_DOUT(1) => nc3011, 
        B_DOUT(0) => nc4181, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][9]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(9), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C16 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%16%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1074, A_DOUT(18) => nc975, 
        A_DOUT(17) => nc1388, A_DOUT(16) => nc6144, A_DOUT(15)
         => nc611, A_DOUT(14) => nc5680, A_DOUT(13) => nc1530, 
        A_DOUT(12) => nc3142, A_DOUT(11) => nc4419, A_DOUT(10)
         => nc1766, A_DOUT(9) => nc4147, A_DOUT(8) => nc2203, 
        A_DOUT(7) => nc5608, A_DOUT(6) => nc4416, A_DOUT(5) => 
        nc3806, A_DOUT(4) => nc5232, A_DOUT(3) => nc3917, 
        A_DOUT(2) => nc5648, A_DOUT(1) => nc2614, A_DOUT(0) => 
        \R_DATA_TEMPR1[16]\, B_DOUT(19) => nc546, B_DOUT(18) => 
        nc1863, B_DOUT(17) => nc3292, B_DOUT(16) => nc2122, 
        B_DOUT(15) => nc1430, B_DOUT(14) => nc6046, B_DOUT(13)
         => nc4955, B_DOUT(12) => nc3935, B_DOUT(11) => nc5200, 
        B_DOUT(10) => nc4886, B_DOUT(9) => nc2207, B_DOUT(8) => 
        nc1423, B_DOUT(7) => nc5412, B_DOUT(6) => nc3473, 
        B_DOUT(5) => nc3087, B_DOUT(4) => nc2955, B_DOUT(3) => 
        nc3366, B_DOUT(2) => nc5240, B_DOUT(1) => nc4594, 
        B_DOUT(0) => nc5097, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][16]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(16), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C36 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%36%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4143, A_DOUT(18) => nc4140, 
        A_DOUT(17) => nc3341, A_DOUT(16) => nc5223, A_DOUT(15)
         => nc2238, A_DOUT(14) => nc1522, A_DOUT(13) => nc5938, 
        A_DOUT(12) => nc958, A_DOUT(11) => nc4116, A_DOUT(10) => 
        nc3808, A_DOUT(9) => nc3572, A_DOUT(8) => nc5085, 
        A_DOUT(7) => nc3998, A_DOUT(6) => nc422, A_DOUT(5) => 
        nc4812, A_DOUT(4) => nc4244, A_DOUT(3) => nc4447, 
        A_DOUT(2) => nc3014, A_DOUT(1) => nc4815, A_DOUT(0) => 
        \R_DATA_TEMPR2[36]\, B_DOUT(19) => nc4245, B_DOUT(18) => 
        nc5478, B_DOUT(17) => nc4175, B_DOUT(16) => nc5008, 
        B_DOUT(15) => nc4888, B_DOUT(14) => nc3700, B_DOUT(13)
         => nc2321, B_DOUT(12) => nc5227, B_DOUT(11) => nc2840, 
        B_DOUT(10) => nc5048, B_DOUT(9) => nc4780, B_DOUT(8) => 
        nc4357, B_DOUT(7) => nc3337, B_DOUT(6) => nc1283, 
        B_DOUT(5) => nc5732, B_DOUT(4) => nc5555, B_DOUT(3) => 
        nc4636, B_DOUT(2) => nc3792, B_DOUT(1) => nc3688, 
        B_DOUT(0) => nc4991, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][36]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(36), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C24 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%24%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3452, A_DOUT(18) => nc2357, 
        A_DOUT(17) => nc177, A_DOUT(16) => nc3665, A_DOUT(15) => 
        nc5698, A_DOUT(14) => nc135, A_DOUT(13) => nc1287, 
        A_DOUT(12) => nc3280, A_DOUT(11) => nc666, A_DOUT(10) => 
        nc5290, A_DOUT(9) => nc4462, A_DOUT(8) => nc3422, 
        A_DOUT(7) => nc2666, A_DOUT(6) => nc4717, A_DOUT(5) => 
        nc5376, A_DOUT(4) => nc5062, A_DOUT(3) => nc1312, 
        A_DOUT(2) => nc3804, A_DOUT(1) => nc2985, A_DOUT(0) => 
        \R_DATA_TEMPR0[24]\, B_DOUT(19) => nc1408, B_DOUT(18) => 
        nc1598, B_DOUT(17) => nc4375, B_DOUT(16) => nc146, 
        B_DOUT(15) => nc4851, B_DOUT(14) => nc3831, B_DOUT(13)
         => nc2791, B_DOUT(12) => nc740, B_DOUT(11) => nc98, 
        B_DOUT(10) => nc1199, B_DOUT(9) => nc4884, B_DOUT(8) => 
        nc3088, B_DOUT(7) => nc3249, B_DOUT(6) => nc2851, 
        B_DOUT(5) => nc2919, B_DOUT(4) => nc5098, B_DOUT(3) => 
        nc3364, B_DOUT(2) => nc918, B_DOUT(1) => nc4151, 
        B_DOUT(0) => nc3131, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][24]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(24), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C6 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%6%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc648, A_DOUT(18) => nc4673, 
        A_DOUT(17) => nc3904, A_DOUT(16) => nc1424, A_DOUT(15)
         => nc6114, A_DOUT(14) => nc3474, A_DOUT(13) => nc371, 
        A_DOUT(12) => nc2151, A_DOUT(11) => nc2229, A_DOUT(10)
         => nc5182, A_DOUT(9) => nc4679, A_DOUT(8) => nc4642, 
        A_DOUT(7) => nc4984, A_DOUT(6) => nc1521, A_DOUT(5) => 
        nc4724, A_DOUT(4) => nc3571, A_DOUT(3) => nc2706, 
        A_DOUT(2) => nc5675, A_DOUT(1) => nc5567, A_DOUT(0) => 
        \R_DATA_TEMPR1[6]\, B_DOUT(19) => nc2387, B_DOUT(18) => 
        nc2372, B_DOUT(17) => nc1117, B_DOUT(16) => nc1306, 
        B_DOUT(15) => nc2803, B_DOUT(14) => nc6016, B_DOUT(13)
         => nc1251, B_DOUT(12) => nc464, B_DOUT(11) => nc5236, 
        B_DOUT(10) => nc234, B_DOUT(9) => nc4856, B_DOUT(8) => 
        nc4320, B_DOUT(7) => nc3836, B_DOUT(6) => nc1636, 
        B_DOUT(5) => nc4671, B_DOUT(4) => nc5453, B_DOUT(3) => 
        nc3296, B_DOUT(2) => nc95, B_DOUT(1) => nc4319, B_DOUT(0)
         => nc5726, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][6]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(6), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[8]\ : OR4
      port map(A => \R_DATA_TEMPR0[8]\, B => \R_DATA_TEMPR1[8]\, 
        C => \R_DATA_TEMPR2[8]\, D => \R_DATA_TEMPR3[8]\, Y => 
        R_DATA(8));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C32 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%32%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5381, A_DOUT(18) => nc5552, 
        A_DOUT(17) => nc2856, A_DOUT(16) => nc5001, A_DOUT(15)
         => nc3449, A_DOUT(14) => nc182, A_DOUT(13) => nc1053, 
        A_DOUT(12) => nc387, A_DOUT(11) => nc5765, A_DOUT(10) => 
        nc5041, A_DOUT(9) => nc3308, A_DOUT(8) => nc1113, 
        A_DOUT(7) => nc1110, A_DOUT(6) => nc5823, A_DOUT(5) => 
        nc503, A_DOUT(4) => nc3446, A_DOUT(3) => nc4526, 
        A_DOUT(2) => nc1342, A_DOUT(1) => nc2881, A_DOUT(0) => 
        \R_DATA_TEMPR0[32]\, B_DOUT(19) => nc309, B_DOUT(18) => 
        nc1062, B_DOUT(17) => nc5374, B_DOUT(16) => nc4858, 
        B_DOUT(15) => nc3838, B_DOUT(14) => nc1214, B_DOUT(13)
         => nc4538, B_DOUT(12) => nc1417, B_DOUT(11) => nc1215, 
        B_DOUT(10) => nc2429, B_DOUT(9) => nc4388, B_DOUT(8) => 
        nc2858, B_DOUT(7) => nc634, B_DOUT(6) => nc1786, 
        B_DOUT(5) => nc1605, B_DOUT(4) => nc4139, B_DOUT(3) => 
        nc4750, B_DOUT(2) => nc3730, B_DOUT(1) => nc2426, 
        B_DOUT(0) => nc2181, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][32]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(32), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C35 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%35%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc707, A_DOUT(18) => nc2177, 
        A_DOUT(17) => nc6000, A_DOUT(16) => nc5907, A_DOUT(15)
         => nc4090, A_DOUT(14) => nc6082, A_DOUT(13) => nc3146, 
        A_DOUT(12) => nc5947, A_DOUT(11) => nc2750, A_DOUT(10)
         => nc1883, A_DOUT(9) => nc6223, A_DOUT(8) => nc1857, 
        A_DOUT(7) => nc1323, A_DOUT(6) => nc4212, A_DOUT(5) => 
        nc3842, A_DOUT(4) => nc3373, A_DOUT(3) => nc3845, 
        A_DOUT(2) => nc2568, A_DOUT(1) => nc2169, A_DOUT(0) => 
        \R_DATA_TEMPR0[35]\, B_DOUT(19) => nc2126, B_DOUT(18) => 
        nc152, B_DOUT(17) => nc229, B_DOUT(16) => nc1472, 
        B_DOUT(15) => nc1567, B_DOUT(14) => nc2173, B_DOUT(13)
         => nc2170, B_DOUT(12) => nc357, B_DOUT(11) => nc5004, 
        B_DOUT(10) => nc6227, B_DOUT(9) => nc2822, B_DOUT(8) => 
        nc4918, B_DOUT(7) => nc3081, B_DOUT(6) => nc2825, 
        B_DOUT(5) => nc5634, B_DOUT(4) => nc4793, B_DOUT(3) => 
        nc2241, B_DOUT(2) => nc1147, B_DOUT(1) => nc5660, 
        B_DOUT(0) => nc5044, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][35]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(35), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C38 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%38%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2274, A_DOUT(18) => nc5091, 
        A_DOUT(17) => nc3694, A_DOUT(16) => nc2477, A_DOUT(15)
         => nc2886, A_DOUT(14) => nc1304, A_DOUT(13) => nc2275, 
        A_DOUT(12) => nc240, A_DOUT(11) => nc798, A_DOUT(10) => 
        nc4125, A_DOUT(9) => nc3560, A_DOUT(8) => nc5289, 
        A_DOUT(7) => nc91, A_DOUT(6) => nc4854, A_DOUT(5) => 
        nc3834, A_DOUT(4) => nc4708, A_DOUT(3) => nc3203, 
        A_DOUT(2) => nc2043, A_DOUT(1) => nc2854, A_DOUT(0) => 
        \R_DATA_TEMPR1[38]\, B_DOUT(19) => nc5454, B_DOUT(18) => 
        nc1765, B_DOUT(17) => nc2888, B_DOUT(16) => nc1143, 
        B_DOUT(15) => nc1140, B_DOUT(14) => nc4712, B_DOUT(13)
         => nc3987, B_DOUT(12) => nc4283, B_DOUT(11) => nc542, 
        B_DOUT(10) => nc3747, B_DOUT(9) => nc5997, B_DOUT(8) => 
        nc3460, B_DOUT(7) => nc3207, B_DOUT(6) => nc1244, 
        B_DOUT(5) => nc5551, B_DOUT(4) => nc4954, B_DOUT(3) => 
        nc3934, B_DOUT(2) => nc2935, B_DOUT(1) => nc1447, 
        B_DOUT(0) => nc1245, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][38]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(38), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C26 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%26%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2780, A_DOUT(18) => nc5065, 
        A_DOUT(17) => nc1057, A_DOUT(16) => nc1538, A_DOUT(15)
         => nc3412, A_DOUT(14) => nc2954, A_DOUT(13) => nc1612, 
        A_DOUT(12) => nc4287, A_DOUT(11) => nc6159, A_DOUT(10)
         => nc2727, A_DOUT(9) => nc4509, A_DOUT(8) => nc949, 
        A_DOUT(7) => nc1139, A_DOUT(6) => nc6043, A_DOUT(5) => 
        nc3084, A_DOUT(4) => nc2847, A_DOUT(3) => nc875, 
        A_DOUT(2) => nc5718, A_DOUT(1) => nc148, A_DOUT(0) => 
        \R_DATA_TEMPR1[26]\, B_DOUT(19) => nc5094, B_DOUT(18) => 
        nc4, B_DOUT(17) => nc4325, B_DOUT(16) => nc161, 
        B_DOUT(15) => nc5489, B_DOUT(14) => nc585, B_DOUT(13) => 
        nc112, B_DOUT(12) => nc5570, B_DOUT(11) => nc317, 
        B_DOUT(10) => nc5486, B_DOUT(9) => nc2337, B_DOUT(8) => 
        nc570, B_DOUT(7) => nc2002, B_DOUT(6) => nc4573, 
        B_DOUT(5) => nc1660, B_DOUT(4) => nc4623, B_DOUT(3) => 
        nc4595, B_DOUT(2) => nc1658, B_DOUT(1) => nc574, 
        B_DOUT(0) => nc2884, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][26]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(26), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C29 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%29%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1920, A_DOUT(18) => nc4358, 
        A_DOUT(17) => nc3338, A_DOUT(16) => nc3970, A_DOUT(15)
         => nc2794, A_DOUT(14) => nc4972, A_DOUT(13) => nc824, 
        A_DOUT(12) => nc631, A_DOUT(11) => nc4629, A_DOUT(10) => 
        nc2672, A_DOUT(9) => nc5939, A_DOUT(8) => nc5519, 
        A_DOUT(7) => nc5470, A_DOUT(6) => nc3999, A_DOUT(5) => 
        nc1425, A_DOUT(4) => nc3349, A_DOUT(3) => nc2358, 
        A_DOUT(2) => nc3475, A_DOUT(1) => nc1250, A_DOUT(0) => 
        \R_DATA_TEMPR0[29]\, B_DOUT(19) => nc5186, B_DOUT(18) => 
        nc3758, B_DOUT(17) => nc5882, B_DOUT(16) => nc5353, 
        B_DOUT(15) => nc5022, B_DOUT(14) => nc997, B_DOUT(13) => 
        nc5885, B_DOUT(12) => nc4906, B_DOUT(11) => nc2390, 
        B_DOUT(10) => nc842, B_DOUT(9) => nc267, B_DOUT(8) => 
        nc2984, B_DOUT(7) => nc2329, B_DOUT(6) => nc6238, 
        B_DOUT(5) => nc4216, B_DOUT(4) => nc2831, B_DOUT(3) => 
        nc4621, B_DOUT(2) => nc4768, B_DOUT(1) => nc3728, 
        B_DOUT(0) => nc1791, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][29]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(29), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C2 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%2%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2047, A_DOUT(18) => nc555, 
        A_DOUT(17) => nc4448, A_DOUT(16) => nc1421, A_DOUT(15)
         => nc1058, A_DOUT(14) => nc3471, A_DOUT(13) => nc2507, 
        A_DOUT(12) => nc1065, A_DOUT(11) => nc1500, A_DOUT(10)
         => nc10, A_DOUT(9) => nc1642, A_DOUT(8) => nc800, 
        A_DOUT(7) => nc2596, A_DOUT(6) => nc28, A_DOUT(5) => 
        nc2131, A_DOUT(4) => nc5162, A_DOUT(3) => nc1082, 
        A_DOUT(2) => nc401, A_DOUT(1) => nc378, A_DOUT(0) => 
        \R_DATA_TEMPR0[2]\, B_DOUT(19) => nc3559, B_DOUT(18) => 
        nc6177, B_DOUT(17) => nc4677, B_DOUT(16) => nc4178, 
        B_DOUT(15) => nc579, B_DOUT(14) => nc6085, B_DOUT(13) => 
        nc3706, B_DOUT(12) => nc3242, B_DOUT(11) => nc164, 
        B_DOUT(10) => nc2312, B_DOUT(9) => nc1400, B_DOUT(8) => 
        nc5527, B_DOUT(7) => nc5916, B_DOUT(6) => nc4786, 
        B_DOUT(5) => nc6047, B_DOUT(4) => nc3803, B_DOUT(3) => 
        nc2705, B_DOUT(2) => nc4569, B_DOUT(1) => nc3529, 
        B_DOUT(0) => nc5787, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][2]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(2), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \INVBLKX0[0]\ : CFG1
      generic map(INIT => "01")

      port map(A => W_ADDR(14), Y => \BLKX0[0]\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C32 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%32%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4253, A_DOUT(18) => nc3233, 
        A_DOUT(17) => nc2222, A_DOUT(16) => nc3948, A_DOUT(15)
         => nc2648, A_DOUT(14) => nc2388, A_DOUT(13) => nc6211, 
        A_DOUT(12) => nc5361, A_DOUT(11) => nc3666, A_DOUT(10)
         => nc6173, A_DOUT(9) => nc6170, A_DOUT(8) => nc2253, 
        A_DOUT(7) => nc4883, A_DOUT(6) => nc2836, A_DOUT(5) => 
        nc4346, A_DOUT(4) => nc4973, A_DOUT(3) => nc4493, 
        A_DOUT(2) => nc4257, A_DOUT(1) => nc3237, A_DOUT(0) => 
        \R_DATA_TEMPR1[32]\, B_DOUT(19) => nc2240, B_DOUT(18) => 
        nc1587, B_DOUT(17) => nc4879, B_DOUT(16) => nc46, 
        B_DOUT(15) => nc2928, B_DOUT(14) => nc4709, B_DOUT(13)
         => nc5725, B_DOUT(12) => nc4592, B_DOUT(11) => nc25, 
        B_DOUT(10) => nc6013, B_DOUT(9) => nc2257, B_DOUT(8) => 
        nc4614, B_DOUT(7) => nc2195, B_DOUT(6) => nc980, 
        B_DOUT(5) => nc3742, B_DOUT(4) => nc2838, B_DOUT(3) => 
        nc2117, B_DOUT(2) => nc3956, B_DOUT(1) => nc642, 
        B_DOUT(0) => nc1124, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][32]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(32), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C21 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%21%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2048, A_DOUT(18) => nc515, 
        A_DOUT(17) => nc3174, A_DOUT(16) => nc4731, A_DOUT(15)
         => nc2730, A_DOUT(14) => nc2722, A_DOUT(13) => nc1785, 
        A_DOUT(12) => nc938, A_DOUT(11) => nc861, A_DOUT(10) => 
        nc6240, A_DOUT(9) => nc2600, A_DOUT(8) => nc4966, 
        A_DOUT(7) => nc3926, A_DOUT(6) => nc4645, A_DOUT(5) => 
        nc5950, A_DOUT(4) => nc1162, A_DOUT(3) => nc32, A_DOUT(2)
         => nc2113, A_DOUT(1) => nc2110, A_DOUT(0) => 
        \R_DATA_TEMPR2[21]\, B_DOUT(19) => nc5402, B_DOUT(18) => 
        nc5719, B_DOUT(17) => nc5389, B_DOUT(16) => nc5455, 
        B_DOUT(15) => nc1026, B_DOUT(14) => nc3076, B_DOUT(13)
         => nc823, B_DOUT(12) => nc4208, B_DOUT(11) => nc2761, 
        B_DOUT(10) => nc2214, B_DOUT(9) => nc5676, B_DOUT(8) => 
        nc5442, B_DOUT(7) => nc2417, B_DOUT(6) => nc2215, 
        B_DOUT(5) => nc2283, B_DOUT(4) => nc6182, B_DOUT(3) => 
        nc6048, B_DOUT(2) => nc129, B_DOUT(1) => nc340, B_DOUT(0)
         => nc5620, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][21]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(21), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C14 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%14%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1051, A_DOUT(18) => nc950, 
        A_DOUT(17) => nc2395, A_DOUT(16) => nc5269, A_DOUT(15)
         => nc1361, A_DOUT(14) => nc1778, A_DOUT(13) => nc448, 
        A_DOUT(12) => nc5451, A_DOUT(11) => nc2287, A_DOUT(10)
         => nc2834, A_DOUT(9) => nc4344, A_DOUT(8) => nc2005, 
        A_DOUT(7) => nc723, A_DOUT(6) => nc1418, A_DOUT(5) => 
        nc21, A_DOUT(4) => nc2693, A_DOUT(3) => nc1680, A_DOUT(2)
         => nc3759, A_DOUT(1) => nc1957, A_DOUT(0) => 
        \R_DATA_TEMPR1[14]\, B_DOUT(19) => nc4494, B_DOUT(18) => 
        nc5282, B_DOUT(17) => nc4523, B_DOUT(16) => nc2699, 
        B_DOUT(15) => nc5218, B_DOUT(14) => nc6022, B_DOUT(13)
         => nc729, B_DOUT(12) => nc2934, B_DOUT(11) => nc4922, 
        B_DOUT(10) => nc5025, B_DOUT(9) => nc4591, B_DOUT(8) => 
        nc3246, B_DOUT(7) => nc3568, B_DOUT(6) => nc4919, 
        B_DOUT(5) => nc1606, B_DOUT(4) => nc3482, B_DOUT(3) => 
        nc667, B_DOUT(2) => nc6017, B_DOUT(1) => nc4756, 
        B_DOUT(0) => nc3736, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][14]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(14), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C35 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%35%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1579, A_DOUT(18) => nc4769, 
        A_DOUT(17) => nc3729, A_DOUT(16) => nc5492, A_DOUT(15)
         => nc5988, A_DOUT(14) => nc3169, A_DOUT(13) => nc1731, 
        A_DOUT(12) => nc1820, A_DOUT(11) => nc2756, A_DOUT(10)
         => nc3870, A_DOUT(9) => nc1054, A_DOUT(8) => nc792, 
        A_DOUT(7) => nc4853, A_DOUT(6) => nc3833, A_DOUT(5) => 
        nc2226, A_DOUT(4) => nc2691, A_DOUT(3) => nc5469, 
        A_DOUT(2) => nc3718, A_DOUT(1) => nc304, A_DOUT(0) => 
        \R_DATA_TEMPR1[35]\, B_DOUT(19) => nc4079, B_DOUT(18) => 
        nc2853, B_DOUT(17) => nc497, B_DOUT(16) => nc5466, 
        B_DOUT(15) => nc2478, B_DOUT(14) => nc1085, B_DOUT(13)
         => nc1316, B_DOUT(12) => nc489, B_DOUT(11) => nc680, 
        B_DOUT(10) => nc3002, B_DOUT(9) => nc2041, B_DOUT(8) => 
        nc3258, B_DOUT(7) => nc202, B_DOUT(6) => nc5782, 
        B_DOUT(5) => nc910, B_DOUT(4) => nc2612, B_DOUT(3) => 
        nc423, B_DOUT(2) => nc1269, B_DOUT(1) => nc4082, 
        B_DOUT(0) => nc5154, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][35]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(35), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C30 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%30%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2338, A_DOUT(18) => nc4627, 
        A_DOUT(17) => nc4128, A_DOUT(16) => nc5166, A_DOUT(15)
         => nc1794, A_DOUT(14) => nc93, A_DOUT(13) => nc4268, 
        A_DOUT(12) => nc3228, A_DOUT(11) => nc261, A_DOUT(10) => 
        nc5862, A_DOUT(9) => nc3519, A_DOUT(8) => nc6210, 
        A_DOUT(7) => nc5865, A_DOUT(6) => nc1448, A_DOUT(5) => 
        nc1976, A_DOUT(4) => nc5578, A_DOUT(3) => nc2947, 
        A_DOUT(2) => nc226, A_DOUT(1) => nc2102, A_DOUT(0) => 
        \R_DATA_TEMPR3[30]\, B_DOUT(19) => nc59, B_DOUT(18) => 
        nc4393, B_DOUT(17) => nc6041, B_DOUT(16) => nc5332, 
        B_DOUT(15) => nc3644, B_DOUT(14) => nc1390, B_DOUT(13)
         => nc5179, B_DOUT(12) => nc5056, B_DOUT(11) => nc3392, 
        B_DOUT(10) => nc1615, B_DOUT(9) => nc3507, B_DOUT(8) => 
        nc2376, B_DOUT(7) => nc2786, B_DOUT(6) => nc922, 
        B_DOUT(5) => nc4923, B_DOUT(4) => nc6018, B_DOUT(3) => 
        nc459, B_DOUT(2) => nc650, B_DOUT(1) => nc4829, B_DOUT(0)
         => nc4587, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][30]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(30), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C37 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%37%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2624, A_DOUT(18) => nc5122, 
        A_DOUT(17) => nc2044, A_DOUT(16) => nc2883, A_DOUT(15)
         => nc1596, A_DOUT(14) => nc4540, A_DOUT(13) => nc175, 
        A_DOUT(12) => nc2301, A_DOUT(11) => nc445, A_DOUT(10) => 
        nc343, A_DOUT(9) => nc1469, A_DOUT(8) => nc245, A_DOUT(7)
         => nc1466, A_DOUT(6) => nc5767, A_DOUT(5) => nc3705, 
        A_DOUT(4) => nc1346, A_DOUT(3) => nc132, A_DOUT(2) => 
        nc1314, A_DOUT(1) => nc3916, A_DOUT(0) => 
        \R_DATA_TEMPR3[37]\, B_DOUT(19) => nc337, B_DOUT(18) => 
        nc1508, B_DOUT(17) => nc4440, B_DOUT(16) => nc2233, 
        B_DOUT(15) => nc1182, B_DOUT(14) => nc2675, B_DOUT(13)
         => nc5137, B_DOUT(12) => nc4785, B_DOUT(11) => nc5321, 
        B_DOUT(10) => nc625, B_DOUT(9) => nc3197, B_DOUT(8) => 
        nc1109, B_DOUT(7) => nc6044, B_DOUT(6) => nc5286, 
        B_DOUT(5) => nc4574, B_DOUT(4) => nc123, B_DOUT(3) => 
        nc701, B_DOUT(2) => nc1779, B_DOUT(1) => nc1166, 
        B_DOUT(0) => nc4734, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][37]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(37), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C34 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%34%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2237, A_DOUT(18) => nc1862, 
        A_DOUT(17) => nc5850, A_DOUT(16) => nc1865, A_DOUT(15)
         => nc508, A_DOUT(14) => nc5133, A_DOUT(13) => nc5130, 
        A_DOUT(12) => nc704, A_DOUT(11) => nc3193, A_DOUT(10) => 
        nc3190, A_DOUT(9) => nc1381, A_DOUT(8) => nc6186, 
        A_DOUT(7) => nc1195, A_DOUT(6) => nc906, A_DOUT(5) => 
        nc1645, A_DOUT(4) => nc5234, A_DOUT(3) => nc4330, 
        A_DOUT(2) => nc5437, A_DOUT(1) => nc5235, A_DOUT(0) => 
        \R_DATA_TEMPR2[34]\, B_DOUT(19) => nc6131, B_DOUT(18) => 
        nc3294, B_DOUT(17) => nc3497, B_DOUT(16) => nc2374, 
        B_DOUT(15) => nc3295, B_DOUT(14) => nc2764, B_DOUT(13)
         => nc419, B_DOUT(12) => nc610, B_DOUT(11) => nc3949, 
        B_DOUT(10) => nc3600, B_DOUT(9) => nc4971, B_DOUT(8) => 
        nc6025, B_DOUT(7) => nc2593, B_DOUT(6) => nc248, 
        B_DOUT(5) => nc2209, B_DOUT(4) => nc274, B_DOUT(3) => 
        nc5369, B_DOUT(2) => nc4052, B_DOUT(1) => nc3032, 
        B_DOUT(0) => nc4905, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][34]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(34), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[4]\ : OR4
      port map(A => \R_DATA_TEMPR0[4]\, B => \R_DATA_TEMPR1[4]\, 
        C => \R_DATA_TEMPR2[4]\, D => \R_DATA_TEMPR3[4]\, Y => 
        R_DATA(4));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C4 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%4%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4536, A_DOUT(18) => nc4680, 
        A_DOUT(17) => nc2992, A_DOUT(16) => nc4990, A_DOUT(15)
         => nc2360, A_DOUT(14) => nc2929, A_DOUT(13) => nc1278, 
        A_DOUT(12) => nc2052, A_DOUT(11) => nc1221, A_DOUT(10)
         => nc3719, A_DOUT(9) => nc3271, A_DOUT(8) => nc4495, 
        A_DOUT(7) => nc1767, A_DOUT(6) => nc1344, A_DOUT(5) => 
        nc5708, A_DOUT(4) => nc6011, A_DOUT(3) => nc5684, 
        A_DOUT(2) => nc5229, A_DOUT(1) => nc2566, A_DOUT(0) => 
        \R_DATA_TEMPR0[4]\, B_DOUT(19) => nc1023, B_DOUT(18) => 
        nc5748, B_DOUT(17) => nc1395, B_DOUT(16) => nc3073, 
        B_DOUT(15) => nc3005, B_DOUT(14) => nc674, B_DOUT(13) => 
        nc4491, B_DOUT(12) => nc4029, B_DOUT(11) => nc492, 
        B_DOUT(10) => nc4557, B_DOUT(9) => nc4307, B_DOUT(8) => 
        nc3537, B_DOUT(7) => nc5915, B_DOUT(6) => nc4085, 
        B_DOUT(5) => nc5262, B_DOUT(4) => nc70, B_DOUT(3) => 
        nc1734, B_DOUT(2) => nc2557, B_DOUT(1) => nc1693, 
        B_DOUT(0) => nc1289, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][4]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(4), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C28 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%28%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2697, A_DOUT(18) => nc2198, 
        A_DOUT(17) => nc2409, A_DOUT(16) => nc1510, A_DOUT(15)
         => nc5509, A_DOUT(14) => nc3218, A_DOUT(13) => nc1699, 
        A_DOUT(12) => nc4135, A_DOUT(11) => nc2406, A_DOUT(10)
         => nc1827, A_DOUT(9) => nc5968, A_DOUT(8) => nc3877, 
        A_DOUT(7) => nc535, A_DOUT(6) => nc5549, A_DOUT(5) => 
        nc1452, A_DOUT(4) => nc1330, A_DOUT(3) => nc2736, 
        A_DOUT(2) => nc5632, A_DOUT(1) => nc3761, A_DOUT(0) => 
        \R_DATA_TEMPR3[28]\, B_DOUT(19) => nc3692, B_DOUT(18) => 
        nc4755, B_DOUT(17) => nc3735, B_DOUT(16) => nc2082, 
        B_DOUT(15) => nc4646, B_DOUT(14) => nc6014, B_DOUT(13)
         => nc2418, B_DOUT(12) => nc5429, B_DOUT(11) => nc4801, 
        B_DOUT(10) => nc1369, B_DOUT(9) => nc3788, B_DOUT(8) => 
        nc2833, B_DOUT(7) => nc1410, B_DOUT(6) => nc6122, 
        B_DOUT(5) => nc4312, B_DOUT(4) => nc2755, B_DOUT(3) => 
        nc5798, B_DOUT(2) => nc5317, B_DOUT(1) => nc2993, 
        B_DOUT(0) => nc1691, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][28]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(28), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \INVBLKX1[0]\ : CFG1
      generic map(INIT => "01")

      port map(A => W_ADDR(15), Y => \BLKX1[0]\);
    
    \INVBLKY0[0]\ : CFG1
      generic map(INIT => "01")

      port map(A => R_ADDR(14), Y => \BLKY0[0]\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C10 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%10%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2165, A_DOUT(18) => nc5426, 
        A_DOUT(17) => nc3955, A_DOUT(16) => nc2106, A_DOUT(15)
         => nc563, A_DOUT(14) => nc1536, A_DOUT(13) => nc2899, 
        A_DOUT(12) => nc369, A_DOUT(11) => nc2802, A_DOUT(10) => 
        nc5762, A_DOUT(9) => nc2805, A_DOUT(8) => nc4101, 
        A_DOUT(7) => nc2570, A_DOUT(6) => nc745, A_DOUT(5) => 
        nc4965, A_DOUT(4) => nc3925, A_DOUT(3) => nc767, 
        A_DOUT(2) => nc1489, A_DOUT(1) => nc5126, A_DOUT(0) => 
        \R_DATA_TEMPR3[10]\, B_DOUT(19) => nc4335, B_DOUT(18) => 
        nc4070, B_DOUT(17) => nc6104, B_DOUT(16) => nc4194, 
        B_DOUT(15) => nc5989, B_DOUT(14) => nc5906, B_DOUT(13)
         => nc1486, B_DOUT(12) => nc2587, B_DOUT(11) => nc5822, 
        B_DOUT(10) => nc3589, B_DOUT(9) => nc5825, B_DOUT(8) => 
        nc706, B_DOUT(7) => nc5946, B_DOUT(6) => nc5599, 
        B_DOUT(5) => nc3102, B_DOUT(4) => nc6191, B_DOUT(3) => 
        nc5811, B_DOUT(2) => nc1262, B_DOUT(1) => nc23, B_DOUT(0)
         => nc2470, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][10]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(10), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C17 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%17%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3357, A_DOUT(18) => nc2316, 
        A_DOUT(17) => nc1027, A_DOUT(16) => nc4650, A_DOUT(15)
         => nc3630, A_DOUT(14) => nc3077, A_DOUT(13) => nc4806, 
        A_DOUT(12) => nc4117, A_DOUT(11) => nc4633, A_DOUT(10)
         => nc4182, A_DOUT(9) => nc5771, A_DOUT(8) => nc6169, 
        A_DOUT(7) => nc5251, A_DOUT(6) => nc2365, A_DOUT(5) => 
        nc1540, A_DOUT(4) => nc5111, A_DOUT(3) => nc4524, 
        A_DOUT(2) => nc2650, A_DOUT(1) => nc6006, A_DOUT(0) => 
        \R_DATA_TEMPR3[17]\, B_DOUT(19) => nc4096, B_DOUT(18) => 
        nc1186, B_DOUT(17) => nc6155, B_DOUT(16) => nc4639, 
        B_DOUT(15) => nc2442, B_DOUT(14) => nc2707, B_DOUT(13)
         => nc4773, B_DOUT(12) => nc1968, B_DOUT(11) => nc1882, 
        B_DOUT(10) => nc4367, B_DOUT(9) => nc3327, B_DOUT(8) => 
        nc1135, B_DOUT(7) => nc1, B_DOUT(6) => nc1885, B_DOUT(5)
         => nc2785, B_DOUT(4) => nc3301, B_DOUT(3) => nc788, 
        B_DOUT(2) => nc5053, B_DOUT(1) => nc4808, B_DOUT(0) => 
        nc4113, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][17]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(17), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C24 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%24%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4110, A_DOUT(18) => nc2663, 
        A_DOUT(17) => nc671, A_DOUT(16) => nc1440, A_DOUT(15) => 
        nc243, A_DOUT(14) => nc4381, A_DOUT(13) => nc3851, 
        A_DOUT(12) => nc4214, A_DOUT(11) => nc2669, A_DOUT(10)
         => nc5727, A_DOUT(9) => nc4631, A_DOUT(8) => nc4417, 
        A_DOUT(7) => nc4700, A_DOUT(6) => nc4215, A_DOUT(5) => 
        nc1628, A_DOUT(4) => nc2615, A_DOUT(3) => nc4055, 
        A_DOUT(2) => nc3678, A_DOUT(1) => nc3035, A_DOUT(0) => 
        \R_DATA_TEMPR1[24]\, B_DOUT(19) => nc1762, B_DOUT(18) => 
        nc3986, B_DOUT(17) => nc5816, B_DOUT(16) => nc5996, 
        B_DOUT(15) => nc4921, B_DOUT(14) => nc5266, B_DOUT(13)
         => nc2055, B_DOUT(12) => nc3151, B_DOUT(11) => nc930, 
        B_DOUT(10) => nc1220, B_DOUT(9) => nc4861, B_DOUT(8) => 
        nc3821, B_DOUT(7) => nc3270, B_DOUT(6) => nc5709, 
        B_DOUT(5) => nc1701, B_DOUT(4) => nc326, B_DOUT(3) => 
        nc6229, B_DOUT(2) => nc4548, B_DOUT(1) => nc5857, 
        B_DOUT(0) => nc5749, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][24]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(24), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[28]\ : OR4
      port map(A => \R_DATA_TEMPR0[28]\, B => \R_DATA_TEMPR1[28]\, 
        C => \R_DATA_TEMPR2[28]\, D => \R_DATA_TEMPR3[28]\, Y => 
        R_DATA(28));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C11 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%11%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2661, A_DOUT(18) => nc1787, 
        A_DOUT(17) => nc5818, A_DOUT(16) => nc4149, A_DOUT(15)
         => nc1335, A_DOUT(14) => nc4161, A_DOUT(13) => nc3121, 
        A_DOUT(12) => nc506, A_DOUT(11) => nc2680, A_DOUT(10) => 
        nc758, A_DOUT(9) => nc4890, A_DOUT(8) => nc1028, 
        A_DOUT(7) => nc3078, A_DOUT(6) => nc2309, A_DOUT(5) => 
        nc2314, A_DOUT(4) => nc848, A_DOUT(3) => nc5710, 
        A_DOUT(2) => nc1616, A_DOUT(1) => nc4804, A_DOUT(0) => 
        \R_DATA_TEMPR0[11]\, B_DOUT(19) => nc299, B_DOUT(18) => 
        nc2099, B_DOUT(17) => nc3856, B_DOUT(16) => nc1633, 
        B_DOUT(15) => nc4575, B_DOUT(14) => nc3209, B_DOUT(13)
         => nc1639, B_DOUT(12) => nc829, B_DOUT(11) => nc1975, 
        B_DOUT(10) => nc5329, B_DOUT(9) => nc5208, B_DOUT(8) => 
        nc4866, B_DOUT(7) => nc3826, B_DOUT(6) => nc1593, 
        B_DOUT(5) => nc2032, B_DOUT(4) => nc4904, B_DOUT(3) => 
        nc4289, B_DOUT(2) => nc5248, B_DOUT(1) => nc3858, 
        B_DOUT(0) => nc1992, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][11]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(11), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C19 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%19%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3342, A_DOUT(18) => nc3789, 
        A_DOUT(17) => nc2085, A_DOUT(16) => nc6233, A_DOUT(15)
         => nc5799, A_DOUT(14) => nc527, A_DOUT(13) => nc5664, 
        A_DOUT(12) => nc2202, A_DOUT(11) => nc1631, A_DOUT(10)
         => nc5057, A_DOUT(9) => nc3750, A_DOUT(8) => nc987, 
        A_DOUT(7) => nc4612, A_DOUT(6) => nc5814, A_DOUT(5) => 
        nc4868, A_DOUT(4) => nc3828, A_DOUT(3) => nc2676, 
        A_DOUT(2) => nc1266, A_DOUT(1) => nc4152, A_DOUT(0) => 
        \R_DATA_TEMPR1[19]\, B_DOUT(19) => nc3132, B_DOUT(18) => 
        nc2322, B_DOUT(17) => nc1389, B_DOUT(16) => nc16, 
        B_DOUT(15) => nc860, B_DOUT(14) => nc6237, B_DOUT(13) => 
        nc2152, B_DOUT(12) => nc2908, B_DOUT(11) => nc1377, 
        B_DOUT(10) => nc4760, B_DOUT(9) => nc3720, B_DOUT(8) => 
        nc461, B_DOUT(7) => nc6126, B_DOUT(6) => nc5222, 
        B_DOUT(5) => nc978, B_DOUT(4) => nc2537, B_DOUT(3) => 
        nc106, B_DOUT(2) => nc5914, B_DOUT(1) => nc5438, 
        B_DOUT(0) => nc3764, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][19]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(19), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[26]\ : OR4
      port map(A => \R_DATA_TEMPR0[26]\, B => \R_DATA_TEMPR1[26]\, 
        C => \R_DATA_TEMPR2[26]\, D => \R_DATA_TEMPR3[26]\, Y => 
        R_DATA(26));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C1 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%1%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc718, A_DOUT(18) => nc3915, 
        A_DOUT(17) => nc3409, A_DOUT(16) => nc3498, A_DOUT(15)
         => nc700, A_DOUT(14) => nc4308, A_DOUT(13) => nc4351, 
        A_DOUT(12) => nc3406, A_DOUT(11) => nc3331, A_DOUT(10)
         => nc1646, A_DOUT(9) => nc3288, A_DOUT(8) => nc1198, 
        A_DOUT(7) => nc1697, A_DOUT(6) => nc3147, A_DOUT(5) => 
        nc5658, A_DOUT(4) => nc4489, A_DOUT(3) => nc5928, 
        A_DOUT(2) => nc5298, A_DOUT(1) => nc4020, A_DOUT(0) => 
        \R_DATA_TEMPR1[1]\, B_DOUT(19) => nc608, B_DOUT(18) => 
        nc3854, B_DOUT(17) => nc3360, B_DOUT(16) => nc2702, 
        B_DOUT(15) => nc2351, B_DOUT(14) => nc120, B_DOUT(13) => 
        nc4486, B_DOUT(12) => nc439, B_DOUT(11) => nc630, 
        B_DOUT(10) => nc957, B_DOUT(9) => nc1282, B_DOUT(8) => 
        nc5250, B_DOUT(7) => nc1871, B_DOUT(6) => nc2735, 
        B_DOUT(5) => nc2127, B_DOUT(4) => nc894, B_DOUT(3) => 
        nc4473, B_DOUT(2) => nc2594, B_DOUT(1) => nc3106, 
        B_DOUT(0) => nc1758, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[1][1]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(1), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C6 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%6%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4864, A_DOUT(18) => nc3824, 
        A_DOUT(17) => nc4533, A_DOUT(16) => nc3143, A_DOUT(15)
         => nc3140, A_DOUT(14) => nc1021, A_DOUT(13) => nc4572, 
        A_DOUT(12) => nc3802, A_DOUT(11) => nc3566, A_DOUT(10)
         => nc3071, A_DOUT(9) => nc3954, A_DOUT(8) => nc3805, 
        A_DOUT(7) => nc3317, A_DOUT(6) => nc1993, A_DOUT(5) => 
        nc1171, A_DOUT(4) => nc1988, A_DOUT(3) => nc5722, 
        A_DOUT(2) => nc4932, A_DOUT(1) => nc1518, A_DOUT(0) => 
        \R_DATA_TEMPR0[6]\, B_DOUT(19) => nc3244, B_DOUT(18) => 
        nc2510, B_DOUT(17) => nc4186, B_DOUT(16) => nc3447, 
        B_DOUT(15) => nc4723, B_DOUT(14) => nc3245, B_DOUT(13)
         => nc1899, B_DOUT(12) => nc1664, B_DOUT(11) => nc5336, 
        B_DOUT(10) => nc5318, B_DOUT(9) => nc5058, B_DOUT(8) => 
        nc4882, B_DOUT(7) => nc3396, B_DOUT(6) => nc1119, 
        B_DOUT(5) => nc2182, B_DOUT(4) => nc4885, B_DOUT(3) => 
        nc2123, B_DOUT(2) => nc2120, B_DOUT(1) => nc4964, 
        B_DOUT(0) => nc3924, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][6]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(6), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C39 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%39%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5969, A_DOUT(18) => nc2563, 
        A_DOUT(17) => nc5774, A_DOUT(16) => nc2224, A_DOUT(15)
         => nc2427, A_DOUT(14) => nc2225, A_DOUT(13) => nc1927, 
        A_DOUT(12) => nc3977, A_DOUT(11) => nc2962, A_DOUT(10)
         => nc2410, A_DOUT(9) => nc1782, A_DOUT(8) => nc1559, 
        A_DOUT(7) => nc2991, A_DOUT(6) => nc4203, A_DOUT(5) => 
        nc3811, A_DOUT(4) => nc1876, A_DOUT(3) => nc5370, 
        A_DOUT(2) => nc2381, A_DOUT(1) => nc4259, A_DOUT(0) => 
        \R_DATA_TEMPR2[39]\, B_DOUT(19) => nc3239, B_DOUT(18) => 
        nc2630, B_DOUT(17) => nc5382, B_DOUT(16) => nc2578, 
        B_DOUT(15) => nc3707, B_DOUT(14) => nc5635, B_DOUT(13)
         => nc3358, B_DOUT(12) => nc1024, B_DOUT(11) => nc4637, 
        B_DOUT(10) => nc4207, B_DOUT(9) => nc4138, B_DOUT(8) => 
        nc2259, B_DOUT(7) => nc6201, B_DOUT(6) => nc4291, 
        B_DOUT(5) => nc3695, B_DOUT(4) => nc3111, B_DOUT(3) => 
        nc3074, B_DOUT(2) => nc3165, B_DOUT(1) => nc2179, 
        B_DOUT(0) => nc917, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][39]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(39), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C9 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%9%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5576, A_DOUT(18) => nc4787, 
        A_DOUT(17) => nc1878, A_DOUT(16) => nc2206, A_DOUT(15)
         => nc4368, A_DOUT(14) => nc3328, A_DOUT(13) => nc2748, 
        A_DOUT(12) => nc6003, A_DOUT(11) => nc4093, A_DOUT(10)
         => nc1704, A_DOUT(9) => nc97, A_DOUT(8) => nc1770, 
        A_DOUT(7) => nc5213, A_DOUT(6) => nc2667, A_DOUT(5) => 
        nc2168, A_DOUT(4) => nc1548, A_DOUT(3) => nc1533, 
        A_DOUT(2) => nc4933, A_DOUT(1) => nc4474, A_DOUT(0) => 
        \R_DATA_TEMPR2[9]\, B_DOUT(19) => nc2035, B_DOUT(18) => 
        nc200, B_DOUT(17) => nc1956, B_DOUT(16) => nc4525, 
        B_DOUT(15) => nc1932, B_DOUT(14) => nc5334, B_DOUT(13)
         => nc5226, B_DOUT(12) => nc4839, B_DOUT(11) => nc3816, 
        B_DOUT(10) => nc1149, B_DOUT(9) => nc1300, B_DOUT(8) => 
        nc3394, B_DOUT(7) => nc3642, B_DOUT(6) => nc5217, 
        B_DOUT(5) => nc5187, B_DOUT(4) => nc4571, B_DOUT(3) => 
        nc4459, B_DOUT(2) => nc3439, B_DOUT(1) => nc1969, 
        B_DOUT(0) => nc4897, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][9]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(9), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C26 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%26%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2549, A_DOUT(18) => nc4456, 
        A_DOUT(17) => nc3436, A_DOUT(16) => nc3365, A_DOUT(15)
         => nc2459, A_DOUT(14) => nc4741, A_DOUT(13) => nc2963, 
        A_DOUT(12) => nc502, A_DOUT(11) => nc2622, A_DOUT(10) => 
        nc364, A_DOUT(9) => nc1506, A_DOUT(8) => nc3818, 
        A_DOUT(7) => nc3309, A_DOUT(6) => nc2869, A_DOUT(5) => 
        nc39, A_DOUT(4) => nc2456, A_DOUT(3) => nc1286, A_DOUT(2)
         => nc2289, A_DOUT(1) => nc782, A_DOUT(0) => 
        \R_DATA_TEMPR2[26]\, B_DOUT(19) => nc5175, B_DOUT(18) => 
        nc6222, B_DOUT(17) => nc3253, B_DOUT(16) => nc1874, 
        B_DOUT(15) => nc5183, B_DOUT(14) => nc5180, B_DOUT(13)
         => nc5051, B_DOUT(12) => nc893, B_DOUT(11) => nc4389, 
        B_DOUT(10) => nc3710, B_DOUT(9) => nc262, B_DOUT(8) => 
        nc487, B_DOUT(7) => nc5284, B_DOUT(6) => nc5487, 
        B_DOUT(5) => nc3663, B_DOUT(4) => nc5285, B_DOUT(3) => 
        nc4156, B_DOUT(2) => nc3136, B_DOUT(1) => nc199, 
        B_DOUT(0) => nc1099, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][26]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(26), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C3 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%3%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc909, A_DOUT(18) => nc172, 
        A_DOUT(17) => nc6158, A_DOUT(16) => nc5905, A_DOUT(15)
         => nc2604, A_DOUT(14) => nc377, A_DOUT(13) => nc4852, 
        A_DOUT(12) => nc3832, A_DOUT(11) => nc108, A_DOUT(10) => 
        nc4263, A_DOUT(9) => nc3669, A_DOUT(8) => nc3257, 
        A_DOUT(7) => nc3223, A_DOUT(6) => nc1138, A_DOUT(5) => 
        nc1637, A_DOUT(4) => nc4855, A_DOUT(3) => nc3835, 
        A_DOUT(2) => nc643, A_DOUT(1) => nc5945, A_DOUT(0) => 
        \R_DATA_TEMPR2[3]\, B_DOUT(19) => nc2156, B_DOUT(18) => 
        nc4418, B_DOUT(17) => nc1974, B_DOUT(16) => nc2852, 
        B_DOUT(15) => nc943, B_DOUT(14) => nc2855, B_DOUT(13) => 
        nc941, B_DOUT(12) => nc2090, B_DOUT(11) => nc5957, 
        B_DOUT(10) => nc793, B_DOUT(9) => nc4267, B_DOUT(8) => 
        nc3227, B_DOUT(7) => nc1759, B_DOUT(6) => nc4706, 
        B_DOUT(5) => nc3202, B_DOUT(4) => nc2616, B_DOUT(3) => 
        nc5624, B_DOUT(2) => nc2946, B_DOUT(1) => nc626, 
        B_DOUT(0) => nc4373, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][3]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(3), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C22 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%22%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3661, A_DOUT(18) => nc752, 
        A_DOUT(17) => nc1105, A_DOUT(16) => nc1933, A_DOUT(15)
         => nc58, A_DOUT(14) => nc6007, A_DOUT(13) => nc5375, 
        A_DOUT(12) => nc4803, A_DOUT(11) => nc4282, A_DOUT(10)
         => nc4097, A_DOUT(9) => nc799, A_DOUT(8) => nc3814, 
        A_DOUT(7) => nc2489, A_DOUT(6) => nc2132, A_DOUT(5) => 
        nc5307, A_DOUT(4) => nc1839, A_DOUT(3) => nc4423, 
        A_DOUT(2) => nc5054, A_DOUT(1) => nc3908, A_DOUT(0) => 
        \R_DATA_TEMPR3[22]\, B_DOUT(19) => nc457, B_DOUT(18) => 
        nc2486, B_DOUT(17) => nc5347, B_DOUT(16) => nc2793, 
        B_DOUT(15) => nc4522, B_DOUT(14) => nc64, B_DOUT(13) => 
        nc802, B_DOUT(12) => nc4757, B_DOUT(11) => nc3737, 
        B_DOUT(10) => nc1684, B_DOUT(9) => nc4988, B_DOUT(8) => 
        nc5673, B_DOUT(7) => nc3985, B_DOUT(6) => nc4316, 
        B_DOUT(5) => nc7, B_DOUT(4) => nc1378, B_DOUT(3) => 
        nc3914, B_DOUT(2) => nc5995, B_DOUT(1) => nc2757, 
        B_DOUT(0) => nc5716, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][22]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(22), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \INVBLKY1[0]\ : CFG1
      generic map(INIT => "01")

      port map(A => R_ADDR(15), Y => \BLKY1[0]\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C25 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%25%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5679, A_DOUT(18) => nc2331, 
        A_DOUT(17) => nc1258, A_DOUT(16) => nc2186, A_DOUT(15)
         => nc3702, A_DOUT(14) => nc5530, A_DOUT(13) => nc847, 
        A_DOUT(12) => nc3590, A_DOUT(11) => nc2882, A_DOUT(10)
         => nc4698, A_DOUT(9) => nc5801, A_DOUT(8) => nc2885, 
        A_DOUT(7) => nc5813, A_DOUT(6) => nc4039, A_DOUT(5) => 
        nc493, A_DOUT(4) => nc6032, A_DOUT(3) => nc5682, 
        A_DOUT(2) => nc761, A_DOUT(1) => nc4782, A_DOUT(0) => 
        \R_DATA_TEMPR3[25]\, B_DOUT(19) => nc5841, B_DOUT(18) => 
        nc55, B_DOUT(17) => nc1305, B_DOUT(16) => nc424, 
        B_DOUT(15) => nc6200, B_DOUT(14) => nc4290, B_DOUT(13)
         => nc5671, B_DOUT(12) => nc2909, B_DOUT(11) => nc6179, 
        B_DOUT(10) => nc5101, B_DOUT(9) => nc5430, B_DOUT(8) => 
        nc944, B_DOUT(7) => nc1594, B_DOUT(6) => nc2749, 
        B_DOUT(5) => nc3490, B_DOUT(4) => nc3387, B_DOUT(3) => 
        nc5141, B_DOUT(2) => nc568, B_DOUT(1) => nc4615, 
        B_DOUT(0) => nc5397, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][25]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(25), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C29 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%29%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc764, A_DOUT(18) => nc296, 
        A_DOUT(17) => nc2069, A_DOUT(16) => nc966, A_DOUT(15) => 
        nc3756, A_DOUT(14) => nc1603, A_DOUT(13) => nc1711, 
        A_DOUT(12) => nc712, A_DOUT(11) => nc3318, A_DOUT(10) => 
        nc6008, A_DOUT(9) => nc4098, A_DOUT(8) => nc440, 
        A_DOUT(7) => nc5929, A_DOUT(6) => nc1609, A_DOUT(5) => 
        nc4359, A_DOUT(4) => nc3339, A_DOUT(3) => nc992, 
        A_DOUT(2) => nc6226, A_DOUT(1) => nc417, A_DOUT(0) => 
        \R_DATA_TEMPR1[29]\, B_DOUT(19) => nc3853, B_DOUT(18) => 
        nc575, B_DOUT(17) => nc4766, B_DOUT(16) => nc3726, 
        B_DOUT(15) => nc2787, B_DOUT(14) => nc2359, B_DOUT(13)
         => nc1273, B_DOUT(12) => nc5806, B_DOUT(11) => nc2595, 
        B_DOUT(10) => nc4424, B_DOUT(9) => nc1991, B_DOUT(8) => 
        nc5846, B_DOUT(7) => nc4970, B_DOUT(6) => nc3881, 
        B_DOUT(5) => nc2518, B_DOUT(4) => nc5362, B_DOUT(3) => 
        nc4863, B_DOUT(2) => nc4314, B_DOUT(1) => nc3823, 
        B_DOUT(0) => nc602, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][29]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(29), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C33 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%33%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc738, A_DOUT(18) => nc5891, 
        A_DOUT(17) => nc1422, A_DOUT(16) => nc3472, A_DOUT(15)
         => nc1601, A_DOUT(14) => nc649, A_DOUT(13) => nc2239, 
        A_DOUT(12) => nc1989, A_DOUT(11) => nc4521, A_DOUT(10)
         => nc4475, A_DOUT(9) => nc2119, A_DOUT(8) => nc2248, 
        A_DOUT(7) => nc1277, A_DOUT(6) => nc3181, A_DOUT(5) => 
        nc5808, A_DOUT(4) => nc5191, A_DOUT(3) => nc2771, 
        A_DOUT(2) => nc3206, A_DOUT(1) => nc541, A_DOUT(0) => 
        \R_DATA_TEMPR3[33]\, B_DOUT(19) => nc5848, B_DOUT(18) => 
        nc6059, B_DOUT(17) => nc695, B_DOUT(16) => nc4252, 
        B_DOUT(15) => nc3232, B_DOUT(14) => nc51, B_DOUT(13) => 
        nc193, B_DOUT(12) => nc1039, B_DOUT(11) => nc5700, 
        B_DOUT(10) => nc3448, B_DOUT(9) => nc4471, B_DOUT(8) => 
        nc4286, B_DOUT(7) => nc2252, B_DOUT(6) => nc5740, 
        B_DOUT(5) => nc76, B_DOUT(4) => nc300, B_DOUT(3) => nc482, 
        B_DOUT(2) => nc4534, B_DOUT(1) => nc3563, B_DOUT(0) => 
        nc3213, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][33]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(33), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R1C2 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%1%2%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4958, A_DOUT(18) => nc3938, 
        A_DOUT(17) => nc4744, A_DOUT(16) => nc27, A_DOUT(15) => 
        nc3962, A_DOUT(14) => nc2428, A_DOUT(13) => nc5167, 
        A_DOUT(12) => nc3886, A_DOUT(11) => nc1741, A_DOUT(10)
         => nc2958, A_DOUT(9) => nc408, A_DOUT(8) => nc4002, 
        A_DOUT(7) => nc2389, A_DOUT(6) => nc5896, A_DOUT(5) => 
        nc3217, A_DOUT(4) => nc2439, A_DOUT(3) => nc345, 
        A_DOUT(2) => nc4340, A_DOUT(1) => nc2564, A_DOUT(0) => 
        \R_DATA_TEMPR1[2]\, B_DOUT(19) => nc2436, B_DOUT(18) => 
        nc846, B_DOUT(17) => nc4752, B_DOUT(16) => nc3732, 
        B_DOUT(15) => nc5804, B_DOUT(14) => nc3888, B_DOUT(13)
         => nc5163, B_DOUT(12) => nc5160, B_DOUT(11) => nc4323, 
        B_DOUT(10) => nc5898, B_DOUT(9) => nc1362, B_DOUT(8) => 
        nc5844, B_DOUT(7) => nc4931, B_DOUT(6) => nc2493, 
        B_DOUT(5) => nc6165, B_DOUT(4) => nc6092, B_DOUT(3) => 
        nc3346, B_DOUT(2) => nc2752, B_DOUT(1) => nc446, 
        B_DOUT(0) => nc342, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[1][2]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(2), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C16 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%16%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5264, A_DOUT(18) => nc5467, 
        A_DOUT(17) => nc5265, A_DOUT(16) => nc4546, A_DOUT(15)
         => nc3780, A_DOUT(14) => nc2592, A_DOUT(13) => nc121, 
        A_DOUT(12) => nc6001, A_DOUT(11) => nc5636, A_DOUT(10)
         => nc4091, A_DOUT(9) => nc452, A_DOUT(8) => nc5790, 
        A_DOUT(7) => nc3604, A_DOUT(6) => nc3696, A_DOUT(5) => 
        nc4507, A_DOUT(4) => nc2136, A_DOUT(3) => nc5012, 
        A_DOUT(2) => nc5904, A_DOUT(1) => nc3667, A_DOUT(0) => 
        \R_DATA_TEMPR0[16]\, B_DOUT(19) => nc3168, B_DOUT(18) => 
        nc2326, B_DOUT(17) => nc2282, B_DOUT(16) => nc2832, 
        B_DOUT(15) => nc2835, B_DOUT(14) => nc937, B_DOUT(13) => 
        nc4684, B_DOUT(12) => nc970, B_DOUT(11) => nc5944, 
        B_DOUT(10) => nc5573, B_DOUT(9) => nc2961, B_DOUT(8) => 
        nc84, B_DOUT(7) => nc4174, B_DOUT(6) => nc766, B_DOUT(5)
         => nc5972, B_DOUT(4) => nc6035, B_DOUT(3) => nc1776, 
        B_DOUT(2) => nc2988, B_DOUT(1) => nc1090, B_DOUT(0) => 
        nc4997, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][16]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(16), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C11 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%11%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc4510, A_DOUT(18) => nc3645, 
        A_DOUT(17) => nc945, A_DOUT(16) => nc4705, A_DOUT(15) => 
        nc1534, A_DOUT(14) => nc1873, A_DOUT(13) => nc5452, 
        A_DOUT(12) => nc1167, A_DOUT(11) => nc3963, A_DOUT(10)
         => nc3884, A_DOUT(9) => nc227, A_DOUT(8) => nc4076, 
        A_DOUT(7) => nc3869, A_DOUT(6) => nc5894, A_DOUT(5) => 
        nc5517, A_DOUT(4) => nc3052, A_DOUT(3) => nc2625, 
        A_DOUT(2) => nc4410, A_DOUT(1) => nc4145, A_DOUT(0) => 
        \R_DATA_TEMPR2[11]\, B_DOUT(19) => nc6004, B_DOUT(18) => 
        nc4094, B_DOUT(17) => nc2782, B_DOUT(16) => nc6187, 
        B_DOUT(15) => nc5308, B_DOUT(14) => nc1793, B_DOUT(13)
         => nc2737, B_DOUT(12) => nc5348, B_DOUT(11) => nc1503, 
        B_DOUT(10) => nc1163, B_DOUT(9) => nc1160, B_DOUT(8) => 
        nc1955, B_DOUT(7) => nc5488, B_DOUT(6) => nc3984, 
        B_DOUT(5) => nc4062, B_DOUT(4) => nc3022, B_DOUT(3) => 
        nc4256, B_DOUT(2) => nc3236, B_DOUT(1) => nc5994, 
        B_DOUT(0) => nc5677, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][11]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(11), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C13 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%13%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5178, A_DOUT(18) => nc3344, 
        A_DOUT(17) => nc1902, A_DOUT(16) => nc1264, A_DOUT(15)
         => nc1467, A_DOUT(14) => nc1265, A_DOUT(13) => nc3716, 
        A_DOUT(12) => nc124, A_DOUT(11) => nc1931, A_DOUT(10) => 
        nc6218, A_DOUT(9) => nc412, A_DOUT(8) => nc2256, 
        A_DOUT(7) => nc5715, A_DOUT(6) => nc5662, A_DOUT(5) => 
        nc6183, A_DOUT(4) => nc6180, A_DOUT(3) => nc2494, 
        A_DOUT(2) => nc3813, A_DOUT(1) => nc2324, A_DOUT(0) => 
        \R_DATA_TEMPR3[13]\, B_DOUT(19) => nc405, B_DOUT(18) => 
        nc303, B_DOUT(17) => nc3557, B_DOUT(16) => nc1714, 
        B_DOUT(15) => nc4600, B_DOUT(14) => nc3909, B_DOUT(13)
         => nc4920, B_DOUT(12) => nc2591, B_DOUT(11) => nc205, 
        B_DOUT(10) => nc566, B_DOUT(9) => nc5973, B_DOUT(8) => 
        nc4425, B_DOUT(7) => nc4989, B_DOUT(6) => nc4345, 
        B_DOUT(5) => nc1357, B_DOUT(4) => nc5879, B_DOUT(3) => 
        nc4567, B_DOUT(2) => nc3527, B_DOUT(1) => nc4870, 
        B_DOUT(0) => nc4030, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][13]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(13), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C24 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%24%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc42, A_DOUT(18) => nc1310, 
        A_DOUT(17) => nc5538, A_DOUT(16) => nc6132, A_DOUT(15)
         => nc3598, A_DOUT(14) => nc5386, A_DOUT(13) => nc3388, 
        A_DOUT(12) => nc2302, A_DOUT(11) => nc147, A_DOUT(10) => 
        nc5398, A_DOUT(9) => nc5139, A_DOUT(8) => nc1108, 
        A_DOUT(7) => nc1607, A_DOUT(6) => nc3755, A_DOUT(5) => 
        nc3199, A_DOUT(4) => nc2339, A_DOUT(3) => nc5203, 
        A_DOUT(2) => nc4643, A_DOUT(1) => nc289, A_DOUT(0) => 
        \R_DATA_TEMPR2[24]\, B_DOUT(19) => nc4421, B_DOUT(18) => 
        nc1516, B_DOUT(17) => nc5243, B_DOUT(16) => nc4005, 
        B_DOUT(15) => nc4649, B_DOUT(14) => nc2060, B_DOUT(13)
         => nc5610, B_DOUT(12) => nc479, B_DOUT(11) => nc670, 
        B_DOUT(10) => nc2774, B_DOUT(9) => nc4654, B_DOUT(8) => 
        nc3634, B_DOUT(7) => nc4765, B_DOUT(6) => nc3725, 
        B_DOUT(5) => nc2945, B_DOUT(4) => nc1595, B_DOUT(3) => 
        nc5322, B_DOUT(2) => nc4733, B_DOUT(1) => nc821, 
        B_DOUT(0) => nc2286, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][24]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(24), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C16 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%16%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1851, A_DOUT(18) => nc5207, 
        A_DOUT(17) => nc2654, A_DOUT(16) => nc5247, A_DOUT(15)
         => nc2711, A_DOUT(14) => nc1903, A_DOUT(13) => nc2370, 
        A_DOUT(12) => nc5685, A_DOUT(11) => nc1809, A_DOUT(10)
         => nc1151, A_DOUT(9) => nc4641, A_DOUT(8) => nc6095, 
        A_DOUT(7) => nc1662, A_DOUT(6) => nc2393, A_DOUT(5) => 
        nc1728, A_DOUT(4) => nc208, A_DOUT(3) => nc3778, 
        A_DOUT(2) => nc2763, A_DOUT(1) => nc2107, A_DOUT(0) => 
        \R_DATA_TEMPR2[16]\, B_DOUT(19) => nc341, B_DOUT(18) => 
        nc1382, B_DOUT(17) => nc3069, B_DOUT(16) => nc396, 
        B_DOUT(15) => nc2232, B_DOUT(14) => nc1744, B_DOUT(13)
         => nc5015, B_DOUT(12) => nc259, B_DOUT(11) => nc2576, 
        B_DOUT(10) => nc3650, B_DOUT(9) => nc166, B_DOUT(8) => 
        nc2347, B_DOUT(7) => nc760, B_DOUT(6) => nc4616, 
        B_DOUT(5) => nc3283, B_DOUT(4) => nc5293, B_DOUT(3) => 
        nc2938, B_DOUT(2) => nc1340, B_DOUT(1) => nc1115, 
        B_DOUT(0) => nc3540, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][16]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(16), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[39]\ : OR4
      port map(A => \R_DATA_TEMPR0[39]\, B => \R_DATA_TEMPR1[39]\, 
        C => \R_DATA_TEMPR2[39]\, D => \R_DATA_TEMPR3[39]\, Y => 
        R_DATA(39));
    
    \OR4_R_DATA[0]\ : OR4
      port map(A => \R_DATA_TEMPR0[0]\, B => \R_DATA_TEMPR1[0]\, 
        C => \R_DATA_TEMPR2[0]\, D => \R_DATA_TEMPR3[0]\, Y => 
        R_DATA(0));
    
    \OR4_R_DATA[19]\ : OR4
      port map(A => \R_DATA_TEMPR0[19]\, B => \R_DATA_TEMPR1[19]\, 
        C => \R_DATA_TEMPR2[19]\, D => \R_DATA_TEMPR3[19]\, Y => 
        R_DATA(19));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C20 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%20%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc6050, A_DOUT(18) => nc5127, 
        A_DOUT(17) => nc2103, A_DOUT(16) => nc2100, A_DOUT(15)
         => nc1072, A_DOUT(14) => nc1856, A_DOUT(13) => nc1030, 
        A_DOUT(12) => nc5384, A_DOUT(11) => nc4660, A_DOUT(10)
         => nc3620, A_DOUT(9) => nc668, A_DOUT(8) => nc732, 
        A_DOUT(7) => nc1529, A_DOUT(6) => nc2204, A_DOUT(5) => 
        nc3579, A_DOUT(4) => nc2407, A_DOUT(3) => nc2205, 
        A_DOUT(2) => nc4124, A_DOUT(1) => nc3287, A_DOUT(0) => 
        \R_DATA_TEMPR0[20]\, B_DOUT(19) => nc5297, B_DOUT(18) => 
        nc2520, B_DOUT(17) => nc437, B_DOUT(16) => nc1546, 
        B_DOUT(15) => nc899, B_DOUT(14) => nc3440, B_DOUT(13) => 
        nc2684, B_DOUT(12) => nc627, B_DOUT(11) => nc5123, 
        B_DOUT(10) => nc5120, B_DOUT(9) => nc6239, B_DOUT(8) => 
        nc2732, B_DOUT(7) => nc1858, B_DOUT(6) => nc3055, 
        B_DOUT(5) => nc2841, B_DOUT(4) => nc1187, B_DOUT(3) => 
        nc884, B_DOUT(2) => nc4535, B_DOUT(1) => nc4102, 
        B_DOUT(0) => nc5224, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][20]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(20), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C27 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%27%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5427, A_DOUT(18) => nc5225, 
        A_DOUT(17) => nc1733, A_DOUT(16) => nc4026, A_DOUT(15)
         => nc1493, A_DOUT(14) => nc2420, A_DOUT(13) => nc4959, 
        A_DOUT(12) => nc3939, A_DOUT(11) => nc1750, A_DOUT(10)
         => nc5079, A_DOUT(9) => nc597, A_DOUT(8) => nc2141, 
        A_DOUT(7) => nc1577, A_DOUT(6) => nc2175, A_DOUT(5) => 
        nc1592, A_DOUT(4) => nc4065, A_DOUT(3) => nc3025, 
        A_DOUT(2) => nc2959, A_DOUT(1) => nc1315, A_DOUT(0) => 
        \R_DATA_TEMPR0[27]\, B_DOUT(19) => nc3012, B_DOUT(18) => 
        nc1183, B_DOUT(17) => nc1180, B_DOUT(16) => nc2565, 
        B_DOUT(15) => nc5706, B_DOUT(14) => nc53, B_DOUT(13) => 
        nc6192, B_DOUT(12) => nc1284, B_DOUT(11) => nc4301, 
        B_DOUT(10) => nc219, B_DOUT(9) => nc1487, B_DOUT(8) => 
        nc1926, B_DOUT(7) => nc1285, B_DOUT(6) => nc5746, 
        B_DOUT(5) => nc3976, B_DOUT(4) => nc5803, B_DOUT(3) => 
        nc1613, B_DOUT(2) => nc5112, B_DOUT(1) => nc1775, 
        B_DOUT(0) => nc221, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][27]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(27), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C8 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%8%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1145, A_DOUT(18) => nc705, 
        A_DOUT(17) => nc6141, A_DOUT(16) => nc5843, A_DOUT(15)
         => nc3564, A_DOUT(14) => nc2990, A_DOUT(13) => nc2846, 
        A_DOUT(12) => nc1619, A_DOUT(11) => nc854, A_DOUT(10) => 
        nc1854, A_DOUT(9) => nc4492, A_DOUT(8) => nc2495, 
        A_DOUT(7) => nc4271, A_DOUT(6) => nc190, A_DOUT(5) => 
        nc1009, A_DOUT(4) => nc3517, A_DOUT(3) => nc2375, 
        A_DOUT(2) => nc5758, A_DOUT(1) => nc2602, A_DOUT(0) => 
        \R_DATA_TEMPR0[8]\, B_DOUT(19) => nc5468, B_DOUT(18) => 
        nc2848, B_DOUT(17) => nc4820, B_DOUT(16) => nc5311, 
        B_DOUT(15) => nc4518, B_DOUT(14) => nc1611, B_DOUT(13)
         => nc4073, B_DOUT(12) => nc1954, B_DOUT(11) => nc2491, 
        B_DOUT(10) => nc2989, B_DOUT(9) => nc2236, B_DOUT(8) => 
        nc6168, B_DOUT(7) => nc4119, B_DOUT(6) => nc260, 
        B_DOUT(5) => nc6136, B_DOUT(4) => nc2740, B_DOUT(3) => 
        nc3961, B_DOUT(2) => nc3786, B_DOUT(1) => nc3152, 
        B_DOUT(0) => nc2673, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][8]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(8), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C29 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%29%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc1535, A_DOUT(18) => nc4543, 
        A_DOUT(17) => nc4433, A_DOUT(16) => nc5796, A_DOUT(15)
         => nc5622, A_DOUT(14) => nc5580, A_DOUT(13) => nc2679, 
        A_DOUT(12) => nc4942, A_DOUT(11) => nc3715, A_DOUT(10)
         => nc4532, A_DOUT(9) => nc1345, A_DOUT(8) => nc845, 
        A_DOUT(7) => nc3883, A_DOUT(6) => nc1670, A_DOUT(5) => 
        nc1494, A_DOUT(4) => nc203, A_DOUT(3) => nc5893, 
        A_DOUT(2) => nc5559, A_DOUT(1) => nc1729, A_DOUT(0) => 
        \R_DATA_TEMPR2[29]\, B_DOUT(19) => nc4162, B_DOUT(18) => 
        nc3122, B_DOUT(17) => nc3779, B_DOUT(16) => nc4209, 
        B_DOUT(15) => nc562, B_DOUT(14) => nc5574, B_DOUT(13) => 
        nc4877, B_DOUT(12) => nc1591, B_DOUT(11) => nc2463, 
        B_DOUT(10) => nc5480, B_DOUT(9) => nc3351, B_DOUT(8) => 
        nc1682, B_DOUT(7) => nc1643, B_DOUT(6) => nc5366, 
        B_DOUT(5) => nc2671, B_DOUT(4) => nc540, B_DOUT(3) => 
        nc2562, B_DOUT(2) => nc3646, B_DOUT(1) => nc3302, 
        B_DOUT(0) => nc38, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[2][29]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(29), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C14 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%14%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc814, A_DOUT(18) => nc1649, 
        A_DOUT(17) => nc544, A_DOUT(16) => nc1358, A_DOUT(15) => 
        nc2844, A_DOUT(14) => nc969, A_DOUT(13) => nc5731, 
        A_DOUT(12) => nc6127, A_DOUT(11) => nc883, A_DOUT(10) => 
        nc4382, A_DOUT(9) => nc4361, A_DOUT(8) => nc3791, 
        A_DOUT(7) => nc3321, A_DOUT(6) => nc168, A_DOUT(5) => 
        nc2714, A_DOUT(4) => nc2626, A_DOUT(3) => nc1075, 
        A_DOUT(2) => nc189, A_DOUT(1) => nc4647, A_DOUT(0) => 
        \R_DATA_TEMPR0[14]\, B_DOUT(19) => nc4148, B_DOUT(18) => 
        nc5971, B_DOUT(17) => nc5219, B_DOUT(16) => nc1468, 
        B_DOUT(15) => nc3610, B_DOUT(14) => nc1228, B_DOUT(13)
         => nc808, B_DOUT(12) => nc3278, B_DOUT(11) => nc2634, 
        B_DOUT(10) => nc1641, B_DOUT(9) => nc2944, B_DOUT(8) => 
        nc2310, B_DOUT(7) => nc2194, B_DOUT(6) => nc5956, 
        B_DOUT(5) => nc6123, B_DOUT(4) => nc6120, B_DOUT(3) => 
        nc1504, B_DOUT(2) => nc5665, B_DOUT(1) => nc4409, 
        B_DOUT(0) => nc783, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][14]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(14), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R2C2 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%2%2%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc6224, A_DOUT(18) => nc6225, 
        A_DOUT(17) => nc4406, A_DOUT(16) => nc432, A_DOUT(15) => 
        nc6111, A_DOUT(14) => nc3107, A_DOUT(13) => nc4077, 
        A_DOUT(12) => nc35, A_DOUT(11) => nc1433, A_DOUT(10) => 
        nc4943, A_DOUT(9) => nc2516, A_DOUT(8) => nc348, 
        A_DOUT(7) => nc1393, A_DOUT(6) => nc4849, A_DOUT(5) => 
        nc4434, A_DOUT(4) => nc789, A_DOUT(3) => nc1532, 
        A_DOUT(2) => nc6175, A_DOUT(1) => nc2096, A_DOUT(0) => 
        \R_DATA_TEMPR2[2]\, B_DOUT(19) => nc549, B_DOUT(18) => 
        nc853, B_DOUT(17) => nc4187, B_DOUT(16) => nc862, 
        B_DOUT(15) => nc3259, B_DOUT(14) => nc3015, B_DOUT(13)
         => nc4531, B_DOUT(12) => nc159, B_DOUT(11) => nc4106, 
        B_DOUT(10) => nc5002, B_DOUT(9) => nc1253, B_DOUT(8) => 
        nc3103, B_DOUT(7) => nc3100, B_DOUT(6) => nc4802, 
        B_DOUT(5) => nc1366, B_DOUT(4) => nc1901, B_DOUT(3) => 
        nc5364, B_DOUT(2) => nc4805, B_DOUT(1) => nc5042, 
        B_DOUT(0) => nc5419, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[2][2]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(2), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C31 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%31%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2348, A_DOUT(18) => nc3060, 
        A_DOUT(17) => nc778, A_DOUT(16) => nc3204, A_DOUT(15) => 
        nc2464, A_DOUT(14) => nc3407, A_DOUT(13) => nc3205, 
        A_DOUT(12) => nc4269, A_DOUT(11) => nc3229, A_DOUT(10)
         => nc4183, A_DOUT(9) => nc4180, A_DOUT(8) => nc5416, 
        A_DOUT(7) => nc4678, A_DOUT(6) => nc753, A_DOUT(5) => 
        nc1257, A_DOUT(4) => nc2561, A_DOUT(3) => nc4284, 
        A_DOUT(2) => nc4487, A_DOUT(1) => nc4285, A_DOUT(0) => 
        \R_DATA_TEMPR0[31]\, B_DOUT(19) => nc6196, B_DOUT(18) => 
        nc1513, B_DOUT(17) => nc483, B_DOUT(16) => nc5759, 
        B_DOUT(15) => nc4270, B_DOUT(14) => nc1172, B_DOUT(13)
         => nc759, B_DOUT(12) => nc1912, B_DOUT(11) => nc3548, 
        B_DOUT(10) => nc2115, B_DOUT(9) => nc5507, B_DOUT(8) => 
        nc5116, B_DOUT(7) => nc3763, B_DOUT(6) => nc1665, 
        B_DOUT(5) => nc5812, B_DOUT(4) => nc4221, B_DOUT(3) => 
        nc3149, B_DOUT(2) => nc5815, B_DOUT(1) => nc5547, 
        B_DOUT(0) => nc2939, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][31]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(31), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C7 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%7%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc6069, A_DOUT(18) => nc696, 
        A_DOUT(17) => nc5686, A_DOUT(16) => nc523, A_DOUT(15) => 
        nc3459, A_DOUT(14) => nc2890, A_DOUT(13) => nc6232, 
        A_DOUT(12) => nc329, A_DOUT(11) => nc4707, A_DOUT(10) => 
        nc286, A_DOUT(9) => nc2528, A_DOUT(8) => nc4078, 
        A_DOUT(7) => nc31, A_DOUT(6) => nc3082, A_DOUT(5) => 
        nc3456, A_DOUT(4) => nc5092, A_DOUT(3) => nc4023, 
        A_DOUT(2) => nc1371, A_DOUT(1) => nc2129, A_DOUT(0) => 
        \R_DATA_TEMPR0[7]\, B_DOUT(19) => nc4352, B_DOUT(18) => 
        nc4333, B_DOUT(17) => nc3332, B_DOUT(16) => nc813, 
        B_DOUT(15) => nc982, B_DOUT(14) => nc727, B_DOUT(13) => 
        nc4469, B_DOUT(12) => nc3429, B_DOUT(11) => nc1434, 
        B_DOUT(10) => nc5070, B_DOUT(9) => nc5705, B_DOUT(8) => 
        nc2573, B_DOUT(7) => nc2352, B_DOUT(6) => nc119, 
        B_DOUT(5) => nc4466, B_DOUT(4) => nc3426, B_DOUT(3) => 
        nc2243, B_DOUT(2) => nc662, B_DOUT(1) => nc453, B_DOUT(0)
         => nc5745, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][7]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(7), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C5 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%5%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc5258, A_DOUT(18) => nc2972, 
        A_DOUT(17) => nc2408, A_DOUT(16) => nc1531, A_DOUT(15)
         => nc3156, A_DOUT(14) => nc1364, A_DOUT(13) => nc3112, 
        A_DOUT(12) => nc1118, A_DOUT(11) => nc1617, A_DOUT(10)
         => nc3852, A_DOUT(9) => nc2363, A_DOUT(8) => nc1990, 
        A_DOUT(7) => nc3855, A_DOUT(6) => nc2315, A_DOUT(5) => 
        nc2247, A_DOUT(4) => nc5717, A_DOUT(3) => nc713, 
        A_DOUT(2) => nc4827, A_DOUT(1) => nc3602, A_DOUT(0) => 
        \R_DATA_TEMPR3[5]\, B_DOUT(19) => nc1495, B_DOUT(18) => 
        nc3587, B_DOUT(17) => nc4166, B_DOUT(16) => nc3126, 
        B_DOUT(15) => nc5773, B_DOUT(14) => nc5597, B_DOUT(13)
         => nc256, B_DOUT(12) => nc5428, B_DOUT(11) => nc4862, 
        B_DOUT(10) => nc3822, B_DOUT(9) => nc1543, B_DOUT(8) => 
        nc4865, B_DOUT(7) => nc4798, B_DOUT(6) => nc3825, 
        B_DOUT(5) => nc977, B_DOUT(4) => nc4682, B_DOUT(3) => 
        nc4049, B_DOUT(2) => nc494, B_DOUT(1) => nc685, B_DOUT(0)
         => nc2613, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[3][5]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(5), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R3C0 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%3%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc719, A_DOUT(18) => nc1942, 
        A_DOUT(17) => nc4157, A_DOUT(16) => nc3137, A_DOUT(15)
         => nc183, A_DOUT(14) => nc3311, A_DOUT(13) => nc360, 
        A_DOUT(12) => nc952, A_DOUT(11) => nc1913, A_DOUT(10) => 
        nc4309, A_DOUT(9) => nc4711, A_DOUT(8) => nc2619, 
        A_DOUT(7) => nc1819, A_DOUT(6) => nc5560, A_DOUT(5) => 
        nc3565, A_DOUT(4) => nc1000, A_DOUT(3) => nc2157, 
        A_DOUT(2) => nc1491, A_DOUT(1) => nc1756, A_DOUT(0) => 
        \R_DATA_TEMPR3[0]\, B_DOUT(19) => nc468, B_DOUT(18) => 
        nc5600, B_DOUT(17) => nc2677, B_DOUT(16) => nc2178, 
        B_DOUT(15) => nc2306, B_DOUT(14) => nc3785, B_DOUT(13)
         => nc1488, B_DOUT(12) => nc5795, B_DOUT(11) => nc5640, 
        B_DOUT(10) => nc1853, B_DOUT(9) => nc2382, B_DOUT(8) => 
        nc1279, B_DOUT(7) => nc3757, B_DOUT(6) => nc4153, 
        B_DOUT(5) => nc4150, B_DOUT(4) => nc3133, B_DOUT(3) => 
        nc3130, B_DOUT(2) => nc5734, B_DOUT(1) => nc5460, 
        B_DOUT(0) => nc4599, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[3][0]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => R_ADDR(15), 
        A_BLK_EN(0) => R_ADDR(14), A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => W_ADDR(15), B_BLK_EN(0) => W_ADDR(14), 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(0), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    \OR4_R_DATA[2]\ : OR4
      port map(A => \R_DATA_TEMPR0[2]\, B => \R_DATA_TEMPR1[2]\, 
        C => \R_DATA_TEMPR2[2]\, D => \R_DATA_TEMPR3[2]\, Y => 
        R_DATA(2));
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C19 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%19%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc2611, A_DOUT(18) => nc3794, 
        A_DOUT(17) => nc4254, A_DOUT(16) => nc3234, A_DOUT(15)
         => nc4457, A_DOUT(14) => nc3437, A_DOUT(13) => nc2153, 
        A_DOUT(12) => nc2150, A_DOUT(11) => nc4255, A_DOUT(10)
         => nc3235, A_DOUT(9) => nc239, A_DOUT(8) => nc1333, 
        A_DOUT(7) => nc1703, A_DOUT(6) => nc5326, A_DOUT(5) => 
        nc413, A_DOUT(4) => nc4767, A_DOUT(3) => nc3727, 
        A_DOUT(2) => nc2254, A_DOUT(1) => nc2457, A_DOUT(0) => 
        \R_DATA_TEMPR0[19]\, B_DOUT(19) => nc2255, B_DOUT(18) => 
        nc655, B_DOUT(17) => nc5319, B_DOUT(16) => nc5588, 
        B_DOUT(15) => nc2973, B_DOUT(14) => nc5330, B_DOUT(13)
         => nc4202, B_DOUT(12) => nc4027, B_DOUT(11) => nc1148, 
        B_DOUT(10) => nc1647, B_DOUT(9) => nc153, B_DOUT(8) => 
        nc3390, B_DOUT(7) => nc2879, B_DOUT(6) => nc5005, 
        B_DOUT(5) => nc4071, B_DOUT(4) => nc5189, B_DOUT(3) => 
        nc4930, B_DOUT(2) => nc2605, B_DOUT(1) => nc5045, 
        B_DOUT(0) => nc1925, DB_DETECT => OPEN, SB_CORRECT => 
        OPEN, ACCESS_BUSY => \ACCESS_BUSY[0][19]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(19), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    DREQ_FIFO_DREQ_FIFO_0_LSRAM_top_R0C1 : RAM1K20

              generic map(RAMINDEX => "core%65536-65536%40-40%SPEED%0%1%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc3975, A_DOUT(18) => nc4435, 
        A_DOUT(17) => nc216, A_DOUT(16) => nc4908, A_DOUT(15) => 
        nc1386, A_DOUT(14) => nc5536, A_DOUT(13) => nc5575, 
        A_DOUT(12) => nc6236, A_DOUT(11) => nc3680, A_DOUT(10)
         => nc3596, A_DOUT(9) => nc2187, A_DOUT(8) => nc3219, 
        A_DOUT(7) => nc5690, A_DOUT(6) => nc1479, A_DOUT(5) => 
        nc912, A_DOUT(4) => nc1943, A_DOUT(3) => nc5625, 
        A_DOUT(2) => nc2960, A_DOUT(1) => nc4977, A_DOUT(0) => 
        \R_DATA_TEMPR0[1]\, B_DOUT(19) => nc1194, B_DOUT(18) => 
        nc2746, B_DOUT(17) => nc1849, B_DOUT(16) => nc4996, 
        B_DOUT(15) => nc1560, B_DOUT(14) => nc1476, B_DOUT(13)
         => nc4628, B_DOUT(12) => nc3359, B_DOUT(11) => nc5212, 
        B_DOUT(10) => nc4431, B_DOUT(9) => nc2465, B_DOUT(8) => 
        nc603, B_DOUT(7) => nc4544, B_DOUT(6) => nc4702, 
        B_DOUT(5) => nc3463, B_DOUT(4) => nc2304, B_DOUT(3) => 
        nc2843, B_DOUT(2) => nc2183, B_DOUT(1) => nc2180, 
        B_DOUT(0) => nc903, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][1]\, A_ADDR(13) => 
        R_ADDR(13), A_ADDR(12) => R_ADDR(12), A_ADDR(11) => 
        R_ADDR(11), A_ADDR(10) => R_ADDR(10), A_ADDR(9) => 
        R_ADDR(9), A_ADDR(8) => R_ADDR(8), A_ADDR(7) => R_ADDR(7), 
        A_ADDR(6) => R_ADDR(6), A_ADDR(5) => R_ADDR(5), A_ADDR(4)
         => R_ADDR(4), A_ADDR(3) => R_ADDR(3), A_ADDR(2) => 
        R_ADDR(2), A_ADDR(1) => R_ADDR(1), A_ADDR(0) => R_ADDR(0), 
        A_BLK_EN(2) => R_EN, A_BLK_EN(1) => \BLKY1[0]\, 
        A_BLK_EN(0) => \BLKY0[0]\, A_CLK => R_CLK, A_DIN(19) => 
        \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, A_DIN(16)
         => \GND\, A_DIN(15) => \GND\, A_DIN(14) => \GND\, 
        A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11) => 
        \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, A_DIN(8)
         => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, A_DIN(5)
         => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, A_DIN(2)
         => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, A_REN
         => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => \VCC\, A_DOUT_ARST_N => \VCC\, A_DOUT_SRST_N
         => \VCC\, B_ADDR(13) => W_ADDR(13), B_ADDR(12) => 
        W_ADDR(12), B_ADDR(11) => W_ADDR(11), B_ADDR(10) => 
        W_ADDR(10), B_ADDR(9) => W_ADDR(9), B_ADDR(8) => 
        W_ADDR(8), B_ADDR(7) => W_ADDR(7), B_ADDR(6) => W_ADDR(6), 
        B_ADDR(5) => W_ADDR(5), B_ADDR(4) => W_ADDR(4), B_ADDR(3)
         => W_ADDR(3), B_ADDR(2) => W_ADDR(2), B_ADDR(1) => 
        W_ADDR(1), B_ADDR(0) => W_ADDR(0), B_BLK_EN(2) => W_EN, 
        B_BLK_EN(1) => \BLKX1[0]\, B_BLK_EN(0) => \BLKX0[0]\, 
        B_CLK => W_CLK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, 
        B_DIN(6) => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, 
        B_DIN(3) => \GND\, B_DIN(2) => \GND\, B_DIN(1) => \GND\, 
        B_DIN(0) => W_DATA(1), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => \VCC\, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => \VCC\, ECC_EN => \GND\, BUSY_FB
         => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \GND\, 
        A_WIDTH(0) => \GND\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \VCC\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \GND\, B_WIDTH(0) => \GND\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \VCC\, ECC_BYPASS => 
        \GND\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
