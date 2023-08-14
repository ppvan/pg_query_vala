/*
 * Copyright (c) 2023 Phạm Văn Phúc <phuclaplace@gmail.com>
 */

/** Don't use any function or struct in this file */
[CCode (cprefix = "pg_query",cheader_filename = "pg_query.h")]
namespace PGQueryInternal {

    [CCode (cname = "pg_query_split_with_scanner")]
    private SplitResultInternal _split_with_scanner (string query);

    [CCode (cname = "pg_query_split_with_parser")]
    private SplitResultInternal _split_with_parser (string query);


    [CCode (cname = "PgQueryError")]
    private struct ErrorInternal {
        private string message;
        private string funcname;
        private string filename;
        private int lineno;
        private int cursorpos;
        private string context;
    }


    [SimpleType]
    [CCode (cname = "PgQuerySplitResult", destroy_function = "pg_query_free_split_result", has_type_id = false)]
    struct SplitResultInternal {

        [CCode (cname = "stmts", array_length = false)]
        private SplitStatementInternal** stmts;

        private int n_stmts;
        private string stderr_buffer;
        private ErrorInternal error;
    }

    [SimpleType]
    [CCode (cname = "PgQuerySplitStmt")]
    public struct SplitStatementInternal {
        public int stmt_location;
        public int stmt_len;
    }

    //  public struct Result {
    //      public string error;
    //      public string parse_tree;
    //      public string deparsed_query;
    //      public string[] warnings;
    //  }


    //  public class SplitResult {
    //      public SplitStatement[] stmts;
    //      public string stderr_buffer;
    //      public Error error;
    //  }
}
