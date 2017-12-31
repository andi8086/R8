

    IO_BASE           = $8000

    SYSCTRL_BASE      = IO_BASE
    SYSCTRL_B         = SYSCTRL_BASE + 0
    SYSCTRL_A         = SYSCTRL_BASE + 1
    SYSCTRL_DDRB      = SYSCTRL_BASE + 2
    SYSCTRL_DDRA      = SYSCTRL_BASE + 3

    ACIA1_BASE        = IO_BASE + $40
    ACIA1_DAT         = ACIA1_BASE + 0
    ACIA1_STAT        = ACIA1_BASE + 1
    ACIA1_CMD         = ACIA1_BASE + 2
    ACIA1_CTL         = ACIA1_BASE + 3

