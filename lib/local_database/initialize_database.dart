class InitializeBd {
  static const createTableNotepad = '''
   CREATE TABLE notepad(
    id INTEGER NOT NULL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description VARCHAR(200) NOT NULL
   )''';

  static const insertNotepads = [
    '''
    INSERT INTO notepad (title, description)
    VALUES ('Test 2', 'Lore ipsum')
    ''',
    '''
    INSERT INTO notepad (title, description)
    VALUES ('Test 3', 'Lore ipsum')
    ''',
    '''
    INSERT INTO notepad (title, description)
    VALUES ('Test 4', 'Lore ipsum')
    ''',
  ];
}
