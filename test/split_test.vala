const string tests[] = {
    "",
    "",
    "SELECT 1",
    "loc=0,len=8",
    "SELECT 1; SELECT 2",
    "loc=0,len=8;loc=9,len=9",
    "SELECT 1; SELECT 2; SELECT 3",
    "loc=0,len=8;loc=9,len=9;loc=19,len=9",
    "SELECT /* comment with ; */ 1; SELECT 2",
    "loc=0,len=29;loc=30,len=9",
    "SELECT --othercomment with ;\n 1; SELECT 2",
    "loc=0,len=31;loc=32,len=9",
    "CREATE RULE x AS ON SELECT TO tbl DO (SELECT 1; SELECT 2)",
    "loc=0,len=57",
    "SELECT 1;\n;\n-- comment\nSELECT 2;\n;",
    "loc=0,len=8;loc=11,len=20"
};

int main () {

    int return_code = 0;

    for (int i = 0; i < tests.length; i += 2) {
        var statements = PGQuery.split_statement (tests[i], false);
        if (statements == null) {
            var expected = tests[i + 1];
            var actual = "";

            if (expected != actual) {
                print (@"Expected: \"$expected\", got: \"$actual\"\n");
                return_code = 1;
                continue;
            } else {
                print (@"OK: $actual \n");
            }

            continue;
        }

        StringBuilder builder = new StringBuilder ();
        statements.foreach ((stmt) => {
            builder.append (@"loc=$(stmt.location),len=$(stmt.statement.length);");
        });
        builder.truncate (builder.len - 1);

        var expected = tests[i + 1];
        var actual = builder.free_and_steal ();

        if (expected != actual) {
            print (@"Expected: \"$expected\", got: \"$actual\"\n");
            return_code = 1;
            continue;
        } else {
            print (@"OK: $actual \n");
        }
    }

    return return_code;
}