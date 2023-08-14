void main () {
    var stmts = PGQuery.split_statement ("   SELECT now()\n\n\n   ;\n\n\n\n    SELECT 2;", false);

    stmts.foreach (stmt => {
        print (stmt.to_string () + "\n");
    });


    // print ("%d\n", result.statements.length);
}