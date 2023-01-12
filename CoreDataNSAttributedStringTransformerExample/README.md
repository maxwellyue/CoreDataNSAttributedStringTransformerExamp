#  Detailed steps to reproduce the issue.

1. Run this project on simulator or device

2. Click Button "Add One Note" 
    * This step will save some data in CoreData, and the "Transformer" is empty.
    * After click button, added notes will show in list.

3. Open file "CoreDataNSAttributedStringTransformerExample.xcdatamodeld", click "Note", for attribute "attributedContent", fill "NSAttributedStringTransformer" in "Transformer" field.
    * This step will use custom "Transformer"
    
4. Remove comment on file "CoreDataNSAttributedStringTransformerExampleApp.swift" line 16
    * This step will register my custom "Transformer" 
    
5. Re-run this project on simulator or device
    * You can see the "attributedContent" is nil. Previously saved data cannot be retrieved.

6. If remove "NSAttributedStringTransformer" in  "CoreDataNSAttributedStringTransformerExample.xcdatamodeld" file, re-run this project, Notes added before can show content normally.
