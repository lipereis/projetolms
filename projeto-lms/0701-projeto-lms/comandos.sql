-- Configurações recomendadas para app web
PRAGMA foreign_keys = 1;

PRAGMA journal_mode = WAL; -- Persiste
PRAGMA synchronous = NORMAL;

PRAGMA cache_size = 2000;
PRAGMA busy_timeout = 5000;
PRAGMA temp_store = memory;

PRAGMA analysis_limit = 1000;
PRAGMA optimize = 0x10002;