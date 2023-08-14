using PGQueryInternal;

namespace PGQuery {
    public class SplitStatement : Object {
        public int location { get; construct; }

        public string statement { get; set; }

        internal SplitStatement (string statement, int location) {
            Object (location: location, statement: statement);
        }

        public string to_string () {
            return @"[$location, $(statement.length)] $statement";
        }
    }


    /** Strict is true force query to be valid, if not, empty array returned */
    public List<SplitStatement> split_statement (string query, bool strict = false) {
        SplitResultInternal result_internal;
        if (strict) {
            result_internal = _split_with_parser (query);
        } else {
            result_internal = _split_with_scanner (query);
        }
        var statements = new List<SplitStatement> ();

        for (var i = 0; i < result_internal.n_stmts; i++) {
            var tmp = result_internal.stmts[i];

            while (query.get_char (tmp->stmt_location) == ' ') {
                tmp->stmt_location++;
                tmp->stmt_len--;
            }

            string statement = query.substring (tmp->stmt_location, tmp->stmt_len);
            int loc = tmp->stmt_location;
            
            statements.append (new SplitStatement (statement, loc));
        }

        return statements;
    }
}