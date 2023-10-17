Question.destroy_all
#Para no tener errores por el Foreign Key
RecordQuestion.destroy_all
RecordExam.destroy_all

#Level 1 - Artes

Question.create(question: "¿Quién cantaba en Soda Stereo?", answer: "Gustavo Cerati", wrongAnswer1: "Fito Páez", wrongAnswer3: "Luis Spinetta", pointQuestion: 5, exam_id: 1, level_id: 1, wrongAnswer2: "Charly García")
Question.create(question: "¿Quién canta De Musica Ligera?", answer: "Soda Stereo", wrongAnswer1: "Fito Páez", wrongAnswer3: "Divididos", pointQuestion: 5, exam_id: nil, level_id: 1, wrongAnswer2: "La Beriso")
Question.create(question: "¿Quién tiene la BZRP Session más escuchada?", answer: "Shakira", wrongAnswer1: "Quevedo", wrongAnswer3: "Nathy Peluso", pointQuestion: 5, exam_id: 1, level_id: 1, wrongAnswer2: "Nicki Nicole")
Question.create(question: "¿Qué cantante llama a sus fans \"Los Leones con FLow?\"", answer: "Paulo Londra", wrongAnswer1: "Duki", wrongAnswer3: "Trueno", pointQuestion: 5, exam_id: nil, level_id: 1, wrongAnswer2: "Khea")
Question.create(question: "¿Qué cantante es conocido como la cara del trap argentino?", answer: "Duki", wrongAnswer1: "Paulo Londra", wrongAnswer3: "Ysy A", pointQuestion: 5, exam_id: 1, level_id: 1, wrongAnswer2: "Neo Pistea")
Question.create(question: "¿De qué equipo era Pepe Argentino de Casados con Hijos?", answer: "Racing", wrongAnswer1: "River Plate", wrongAnswer3: "Boca Juniors", pointQuestion: 5, exam_id: nil, level_id: 1, wrongAnswer2: "No le gustaba el fútbol")
Question.create(question: "¿Quién es el actor principal de Argentina:1985?", answer: "Ricardo Darín", wrongAnswer1: "Guillermo Francella", wrongAnswer3: "Leonardo Sbaraglia", pointQuestion: 5, exam_id: nil, level_id: 1, wrongAnswer2: "Miguel Ángel Solá")
Question.create(question: "¿Qué artista argentina protagoniza Violetta?", answer: "Martina Stoessel", wrongAnswer1: "Nicki Nicole", wrongAnswer3: "María Becerra", pointQuestion: 5, exam_id: nil, level_id: 1, wrongAnswer2: "Lali Espósito")
Question.create(question: "¿Qué artista argentina protagoniza el Gambito de Dama / Queen's Gambit?", answer: "Anya Taylor-Joy", wrongAnswer1: "Lali Espósito", wrongAnswer3: "Belén Blanco", pointQuestion: 5, exam_id: nil, level_id: 1, wrongAnswer2: "Thelma Fardín")


#Level 2 - Artes


Question.create(question: "¿Qué instrumento era el principal de Fito Páez?", answer: "Teclados", wrongAnswer1: "Cuerdas", wrongAnswer3: "Ninguno", pointQuestion: 10, exam_id: 1, level_id: 2, wrongAnswer2: "Teclados y cuerdas")
Question.create(question: "¿De dónde vienen Duki, Paulo Londra y demás cantantes urbanos?", answer: "El Quinto Escalón", wrongAnswer1: "La Voz Argentina", wrongAnswer3: "FMS Argentina", pointQuestion: 10, exam_id: nil, level_id: 2, wrongAnswer2: "Ningún lugar en común")
Question.create(question: "¿En qué estadio argentino grabó su disco AC/DC?", answer: "El Monumental", wrongAnswer1: "La Bombonera", wrongAnswer3: "Vélez", pointQuestion: 10, exam_id: 1, level_id: 2, wrongAnswer2: "El Cilindro")
Question.create(question: "¿Con qué artista no grabó un tema Fito Páez?", answer: "Gustavo Cerati", wrongAnswer1: "Luis Spinetta", wrongAnswer3: "Charly García", pointQuestion: 10, exam_id: nil, level_id: 2, wrongAnswer2: "Grabó con todos")
Question.create(question: "¿Cuál es el disco más vendido de la historia del país?", answer: "El amor después del amor", wrongAnswer1: "SEP7IMO DÍA", wrongAnswer3: "Ahí vamos", pointQuestion: 10, exam_id: 1, level_id: 2, wrongAnswer2: "Fuerza Natural")

#Level 3 - Artes

Question.create(question: "¿En qué año murió Spinetta?", answer: "2012", wrongAnswer1: "2014", wrongAnswer3: "2008", pointQuestion: 15, exam_id: 1, level_id: 3, wrongAnswer2: "2001")
Question.create(question: "¿En qué año se estrenó la película Metegol?", answer: "2013", wrongAnswer1: "2014", wrongAnswer3: "2016", pointQuestion: 15, exam_id: nil, level_id: 3, wrongAnswer2: "2012")
Question.create(question: "¿En qué año se estrenó El Secreto de sus Ojos?", answer: "2009", wrongAnswer1: "2007", wrongAnswer3: "2012", pointQuestion: 15, exam_id: 1, level_id: 3, wrongAnswer2: "2011")
Question.create(question: "¿Cuántos Oscars ganó Ricardo Darín?", answer: "1", wrongAnswer1: "0", wrongAnswer3: "2", pointQuestion: 15, exam_id: 1, level_id: 3, wrongAnswer2: "3")
Question.create(question: "¿En qué año murió Cerati?", answer: "2014", wrongAnswer1: "2013", wrongAnswer3: "2009", pointQuestion: 15, exam_id: nil, level_id: 3, wrongAnswer2: "2011")



#Level 1 - Comida

Question.create(question: "¿De qué puede ser una milanesa?", answer: "Todas son correctas", wrongAnswer1: "Carne", wrongAnswer3: "Pollo", pointQuestion: 5, exam_id: 2, level_id: 4, wrongAnswer2: "Pescado")
Question.create(question: "¿Qué se suele comer el 25 de mayo?", answer: "Locro", wrongAnswer1: "Todo menos carne", wrongAnswer3: "Pastas", pointQuestion: 5, exam_id: 2, level_id: 4, wrongAnswer2: "Pescado")
Question.create(question: "¿Qué se suele comer sólo en navidad?", answer: "Vitel Toné", wrongAnswer1: "Pescado", wrongAnswer3: "Pastas", pointQuestion: 5, exam_id: nil, level_id: 4, wrongAnswer2: "Milanesa")
Question.create(question: "¿Qué tiene la salsa bolognesa que otras no?", answer: "Carne molida", wrongAnswer1: "Hongos", wrongAnswer3: "Nada, sólo es salsa", pointQuestion: 5, exam_id: 2, level_id: 4, wrongAnswer2: "Verdeo")

#Level 2 - Comida

Question.create(question: "¿De dónde es el Fernet?", answer: "Italia", wrongAnswer1: "Argentina", wrongAnswer3: "Uruguay", pointQuestion: 10, exam_id: nil, level_id: 5, wrongAnswer2: "España")
Question.create(question: "¿Cuál es la comida favorita de Messi?", answer: "Milanesa Napolitana", wrongAnswer1: "Asado", wrongAnswer3: "Empanadas", pointQuestion: 10, exam_id: nil, level_id: 5, wrongAnswer2: "Pastas")
Question.create(question: "¿Con qué se hace el Pritteado, además de Pritty?", answer: "Vino", wrongAnswer1: "Vodka", wrongAnswer3: "Fernet", pointQuestion: 10, exam_id: 2, level_id: 5, wrongAnswer2: "Gin")
Question.create(question: "¿Con qué se suele acompañar el asado?", answer: "Ensalada", wrongAnswer1: "Todas son correctas", wrongAnswer3: "Puré", pointQuestion: 10, exam_id: 2, level_id: 5, wrongAnswer2: "Pasta")
Question.create(question: "¿Con qué se suele mezclar tomar el Gancia?", answer: "Sprite", wrongAnswer1: "Seven up", wrongAnswer3: "Pritty", pointQuestion: 10, exam_id: 2, level_id: 5, wrongAnswer2: "Fanta")

#Level 3 - Comida

Question.create(question: "¿De qué animal está hecho el chorizo?", answer: "Cerdo", wrongAnswer1: "Vaca", wrongAnswer3: "Pollo", pointQuestion: 15, exam_id: 2, level_id: 6, wrongAnswer2: "Cordero")
Question.create(question: "¿Qué tiene el queso azul?", answer: "Tiene hongos", wrongAnswer1: "Tintes naturales", wrongAnswer3: "Mezclas con otros lácteos", pointQuestion: 15, exam_id: 2, level_id: 6, wrongAnswer2: "La leche")
Question.create(question: "¿De qué parte de la vaca es el matambre?", answer: "La panza", wrongAnswer1: "La espalda", wrongAnswer3: "La nalga", pointQuestion: 15, exam_id: 2, level_id: 6, wrongAnswer2: "La costilla")

#Level 1 - Geografia

Question.create(question: "¿En qué provincia está la capital del país?", answer: "No está en ninguna", wrongAnswer1: "Buenos Aires", wrongAnswer3: "Córdoba", pointQuestion: 5, exam_id: 3, level_id: 7, wrongAnswer2: "Santa Fe")
Question.create(question: "¿En qué provincia está Bariloche?", answer: "Río Negro", wrongAnswer1: "Chubut", wrongAnswer3: "Santa Cruz", pointQuestion: 5, exam_id: 3, level_id: 7, wrongAnswer2: "Neuquén")

#Level 2 - Geografia

Question.create(question: "¿Cuál es la única provincia limítrofe de Misiones", answer: "Corrientes", wrongAnswer1: "Buenos Aires", wrongAnswer3: "Formosa", pointQuestion: 10, exam_id: nil, level_id: 8, wrongAnswer2: "Chaco")
Question.create(question: "¿En qué provincia están las Cataratas del Iguazú?", answer: "Misiones", wrongAnswer1: "Entre Ríos", wrongAnswer3: "Corrientes", pointQuestion: 10, exam_id: 3, level_id: 8, wrongAnswer2: "Chaco")
Question.create(question: "¿Cuál es la capital de Misiones?", answer: "Posadas", wrongAnswer1: "Misiones", wrongAnswer3: "Cataratas", pointQuestion: 10, exam_id: nil, level_id: 8, wrongAnswer2: "Entre Ríos")
Question.create(question: "¿Cuál es la capital de Río Negro?", answer: "Viedma", wrongAnswer1: "Río Negro", wrongAnswer3: "Bariloche", pointQuestion: 10, exam_id: 3, level_id: 8, wrongAnswer2: "Rawson")
Question.create(question: "¿Cuál es la capital de Buenos Aires?", answer: "La Plata", wrongAnswer1: "Buenos Aires", wrongAnswer3: "C.A.B.A.", pointQuestion: 10, exam_id: 3, level_id: 8, wrongAnswer2: "Avellaneda")

#Level 3 - Geografia

Question.create(question: "¿Dónde queda Rancul?", answer: "La Pampa", wrongAnswer1: "Córdoba", wrongAnswer3: "San Luis", pointQuestion: 15, exam_id: 3, level_id: 9, wrongAnswer2: "Mendoza")
Question.create(question: "¿Dónde queda General Villegas?", answer: "Buenos Aires", wrongAnswer1: "Córdoba", wrongAnswer3: "La Pampa", pointQuestion: 15, exam_id: 3, level_id: 9, wrongAnswer2: "San Luis")
Question.create(question: "¿Dónde queda Naschel?", answer: "San Luis", wrongAnswer1: "Córdoba", wrongAnswer3: "San Juan", pointQuestion: 15, exam_id: 3, level_id: 9, wrongAnswer2: "La Rioja")
Question.create(question: "¿De dónde es Julián Álvarez?", answer: "Calchín", wrongAnswer1: "Córdoba capital", wrongAnswer3: "Buenos Aires", pointQuestion: 15, exam_id: 3, level_id: 9, wrongAnswer2: "Luque")

#Level 1 - Historia

Question.create(question: "¿En qué año se declaró la independencia de Argentina?", answer: "1816", wrongAnswer1: "1810", wrongAnswer2: "1824", wrongAnswer3: "1830", pointQuestion: 5, exam_id: nil, level_id: 10)
Question.create(question: "¿Quién fue el primer presidente de Argentina?", answer: "Bernardino Rivadavia", wrongAnswer1: "Juan Domingo Perón", wrongAnswer2: "Carlos Menem", wrongAnswer3: "Hipólito Yrigoyen", pointQuestion: 5, exam_id: 4, level_id: 10)
Question.create(question: "¿Cuál fue el nombre del líder político y militar que gobernó Argentina durante gran parte del siglo XX y fue conocido como 'El General'?", answer: "Juan Perón", wrongAnswer1: "Juan Manuel de Rosas", wrongAnswer2: "Domingo Faustino Sarmiento", wrongAnswer3: "José de San Martín", pointQuestion: 5, exam_id: nil, level_id: 10)
Question.create(question: "¿Quién fue el libertador de Argentina, Chile y Perú?", answer: "José de San Martín", wrongAnswer1: "Simón Bolívar", wrongAnswer2: "Manuel Belgrano", wrongAnswer3: "Bernardo O'Higgins", pointQuestion: 5, level_id: 10, exam_id: nil)
Question.create(question: "¿Cuál fue la capital de Argentina antes de Buenos Aires?", answer: "Córdoba", wrongAnswer1: "Rosario", wrongAnswer2: "Mendoza", wrongAnswer3: "La Plata", pointQuestion: 5, level_id: 10, exam_id: 4)
Question.create(question: "¿Cuál es la moneda oficial de Argentina?", answer: "Peso argentino", wrongAnswer1: "Dólar", wrongAnswer2: "Sol", wrongAnswer3: "Austral", pointQuestion: 5, level_id: 10, exam_id: 4)

#Level 2 - Historia

Question.create(question: "¿Cuál fue el nombre de la primera dama de Argentina que ejerció como presidenta entre 2007 y 2015?", answer: "Cristina Fernández de Kirchner", wrongAnswer1: "Eva Perón", wrongAnswer2: "Isabel Perón", wrongAnswer3: "María Estela Martínez de Perón", pointQuestion: 10, exam_id: nil, level_id: 11)
Question.create(question: "¿Qué presidente argentino implementó el Plan de Convertibilidad en la década de 1990?", answer: "Carlos Menem", wrongAnswer1: "Néstor Kirchner", wrongAnswer2: "Fernando de la Rúa", wrongAnswer3: "Raúl Alfonsín", pointQuestion: 10, exam_id: 4, level_id: 11)
Question.create(question: "¿En qué año comenzó la Guerra de Malvinas entre Argentina y el Reino Unido?", answer: "1982", wrongAnswer1: "1976", wrongAnswer2: "1990", wrongAnswer3: "2001", pointQuestion: 10, exam_id: 4, level_id: 11)
Question.create(question: "¿Cuál fue el nombre del movimiento político y social que surgió en Argentina en la década de 1940, liderado por Perón?", answer: "Partido Justicialista", wrongAnswer1: "Montoneros", wrongAnswer2: "Movimiento Evita", wrongAnswer3: "Unión Cívica Radical", pointQuestion: 10, exam_id: nil, level_id: 11)
Question.create(question: "¿Cuál fue la fecha del famoso 'Cabildo Abierto' en Buenos Aires, que marcó un hito en el proceso de independencia de Argentina?", answer: "25 de Mayo de 1810", wrongAnswer1: "9 de Julio de 1816", wrongAnswer2: "20 de Junio de 1810", wrongAnswer3: "9 de Julio de 1810", pointQuestion: 10, exam_id: nil, level_id: 11)
Question.create(question: "¿En qué año se aprobó la Ley de Voto Femenino en Argentina?", answer: "1947", wrongAnswer1: "1955", wrongAnswer2: "1930", wrongAnswer3: "1960", pointQuestion: 10, level_id: 11, exam_id: 4)
Question.create(question: "¿Qué figura histórica argentina es conocida como 'El Padre de la Educación'?", answer: "Domingo Faustino Sarmiento", wrongAnswer1: "Manuel Belgrano", wrongAnswer2: "Bartolomé Mitre", wrongAnswer3: "Juan Bautista Alberdi", pointQuestion: 10, level_id: 11, exam_id: nil)
Question.create(question: "¿Quién gobernó durante la Segunda Guerra Mundial?", answer: "Ramón Castillo", wrongAnswer1: "Roberto Marcelino Ortiz", wrongAnswer2: "Pedro Pablo Ramírez", wrongAnswer3: "Edelmiro Farrell", pointQuestion: 10, level_id: 11, exam_id: nil)

#Level 3 - Historia

Question.create(question: "¿Cuál fue el nombre de la organización guerrillera de extrema izquierda que operó en Argentina durante las décadas de 1960 y 1970?", answer: "Montoneros", wrongAnswer1: "Fuerzas Armadas Revolucionarias (FAR)", wrongAnswer2: "Ejército Revolucionario del Pueblo (ERP)", wrongAnswer3: "Alianza Libertadora Nacionalista (ALN)", pointQuestion: 15, exam_id: 4, level_id: 12)
Question.create(question: "¿Qué presidente argentino fue derrocado por un golpe militar en 1976, dando inicio a un período conocido como la 'Dictadura Militar'?", answer: "Isabel Perón", wrongAnswer1: "Juan Domingo Perón", wrongAnswer2: "Carlos Menem", wrongAnswer3: "Hipólito Yrigoyen", pointQuestion: 15, exam_id: 4, level_id: 12)
Question.create(question: "¿En qué año se inauguró el Obelisco de Buenos Aires?", answer: "1936", wrongAnswer1: "1900", wrongAnswer2: "1925", wrongAnswer3: "1950", pointQuestion: 15, exam_id: 4, level_id: 12)
Question.create(question: "¿Cuál fue el nombre del movimiento guerrillero de extrema derecha que operó en Argentina en la década de 1970?", answer: "Alianza Anticomunista Argentina (Triple A)", wrongAnswer1: "Fuerzas Armadas Revolucionarias (FAR)", wrongAnswer2: "Ejército Revolucionario del Pueblo (ERP)", wrongAnswer3: "Montoneros", pointQuestion: 15, level_id: 12, exam_id: nil)
Question.create(question: "¿Cuál fue el nombre del presidente argentino que asumió tras la renuncia de Fernando de la Rúa en 2001?", answer: "Adolfo Rodríguez Saá", wrongAnswer1: "Eduardo Duhalde", wrongAnswer2: "Néstor Kirchner", wrongAnswer3: "Cristina Fernández de Kirchner", pointQuestion: 15, level_id: 12, exam_id: nil)

#Level 1 - Deportes

Question.create(question: "¿Dónde nació Lionel Messi?", answer: "Rosario", wrongAnswer1: "C.A. Buenos Aires", wrongAnswer3: "Córdoba", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "La Plata")
Question.create(question: "¿Cuál es el clásico de Rosario Central?", answer: "Newell's", wrongAnswer1: "Colón de Santa Fe", wrongAnswer3: "Unión de Santa Fe", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "Instituto A.C.C.")
Question.create(question: "¿Quién es ídolo de Boca entre las opciones de abajo?", answer: "Riquelme", wrongAnswer1: "Diego Ceballos", wrongAnswer3: "Ángel Labruna", pointQuestion: 10, exam_id: 5, level_id: 13, wrongAnswer2: "Diego Milito")
Question.create(question: "¿De qué equipo es Marcelo Gallardo?", answer: "River Plate", wrongAnswer1: "Boca Juniors", wrongAnswer3: "Independiente", pointQuestion: 10, exam_id: 5, level_id: 13, wrongAnswer2: "Racing")
Question.create(question: "¿Cuál es el clásico principal de Boca Juniors?", answer: "River Plate", wrongAnswer1: "Racing", wrongAnswer3: "San Lorenzo", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "Independiente")
Question.create(question: "¿Cómo se llama el estadio de River Plate?", answer: "El Monumental", wrongAnswer1: "La Bombonera", wrongAnswer3: "El Cilindro", pointQuestion: 10, exam_id: 5, level_id: 13, wrongAnswer2: "El Cementerio de Elefantes")
Question.create(question: "¿Quién fue el 10 y referente de la selección en el mundial de 1986?", answer: "Diego Armando Maradona", wrongAnswer1: "Mario Alberto Kempes", wrongAnswer3: "Claudo Caniggia", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "Gabriel Batistuta")
Question.create(question: "¿Cómo se le llama a la Selección de Rugby?", answer: "Los Pumas", wrongAnswer1: "Las Panteras", wrongAnswer3: "Los Leones", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "Los Tigres")
Question.create(question: "¿Cómo se le dice a la Selección de Hockey femenina?", answer: "Las Leonas", wrongAnswer1: "Las Panteras", wrongAnswer3: "Las Pumas", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "Las Tigresas")
Question.create(question: "¿Quíen fue el referente de la Generación Dorada del Basket Argentino?", answer: "Manuel Ginóbili", wrongAnswer1: "Luis Scola", wrongAnswer3: "Juan Martín Del Potro", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "Paulo Dybala")
Question.create(question: "¿Quién hizo goles en las finales jugadas contra Brasil, Italia y Francia entre 2022 y 2023?", answer: "Ángel Di María", wrongAnswer1: "Lionel Messi", wrongAnswer3: "Julián Álvarez", pointQuestion: 10, exam_id: nil, level_id: 13, wrongAnswer2: "Lautaro Martínez")

#Level 2 - Deportes

Question.create(question: "¿En qué equipo de Inglaterra es ídolo el Kun Agüero?", answer: "Manchester City", wrongAnswer1: "Manchester United", wrongAnswer3: "Chelsea", pointQuestion: 15, exam_id: nil, level_id: 14, wrongAnswer2: "Liverpool")
Question.create(question: "¿Que equipo tiene más Copas Libertadores en todo el continente?", answer: "Independiente", wrongAnswer1: "Boca Juniors", wrongAnswer3: "Estudiantes de La Plata", pointQuestion: 15, exam_id: nil, level_id: 14, wrongAnswer2: "River Plate")
Question.create(question: "¿Quién es el argentino con más mundiales?", answer: "Daniel Passarella", wrongAnswer1: "Diego Armando Maradona", wrongAnswer3: "Mario Alberto Kempes", pointQuestion: 15, exam_id: 5, level_id: 14, wrongAnswer2: "Claudio Caniggia")
Question.create(question: "¿En qué equipo de Inglaterra es ídolo el Kun Agüero?", answer: "Manchester City", wrongAnswer1: "Manchester United", wrongAnswer3: "Chelsea", pointQuestion: 15, exam_id: 5, level_id: 14, wrongAnswer2: "Liverpool")
Question.create(question: "¿En dónde se jugó la vuelta de la final de Libertadores entre River y Boca?", answer: "El Santiago Bernabeu", wrongAnswer1: "La Bombonera", wrongAnswer3: "El Monumental", pointQuestion: 15, exam_id: 5, level_id: 14, wrongAnswer2: "El Maracaná")


#Level 3 - Deportes

Question.create(question: "¿Quién es el máximo goleador de la historia de River Plate?", answer: "Ángel Labruna", wrongAnswer1: "Oscar Más", wrongAnswer3: "Bernabé Ferreyra", pointQuestion: 20, exam_id: 5, level_id: 15, wrongAnswer2: "Gonzalo Higuaín")
Question.create(question: "¿Quién es el máximo goleador de la historia de Boca Juniors?", answer: "Martín Palermo", wrongAnswer1: "Juan Román Riquelme", wrongAnswer3: "Carlos Tévez", pointQuestion: 20, exam_id: nil, level_id: 15, wrongAnswer2: "Roberto Cherro")
Question.create(question: "¿Qué argentino fue la venta más cara del fútbol local?", answer: "Lautaro Martínez", wrongAnswer1: "Sergio Agüero", wrongAnswer3: "Lionel Messi", pointQuestion: 20, exam_id: nil, level_id: 15, wrongAnswer2: "Diego Armando Maradona")
Question.create(question: "¿En qué año ganó se jugó la final entre Estudiantes de La Plata y Barcelona?", answer: "2009", wrongAnswer1: "2006", wrongAnswer3: "2008", pointQuestion: 20, exam_id: 5, level_id: 15, wrongAnswer2: "2007")
Question.create(question: "¿En qué año se fundó River Plate?", answer: "1901", wrongAnswer1: "1899", wrongAnswer3: "1903", pointQuestion: 20, exam_id: nil, level_id: 15, wrongAnswer2: "1904")
Question.create(question: "¿En qué año Boca Juniors ganó su primera Libertadores?", answer: "1977", wrongAnswer1: "1980", wrongAnswer3: "1992", pointQuestion: 20, exam_id: nil, level_id: 15, wrongAnswer2: "1989")
Question.create(question: "¿En qué año Independiente ganó su última Libertadores?", answer: "1975", wrongAnswer1: "1991", wrongAnswer3: "1983", pointQuestion: 20, exam_id: 5, level_id: 15, wrongAnswer2: "1984")
Question.create(question: "¿En qué año ganó su única Intercontinental Racing Club?", answer: "1967", wrongAnswer1: "1993", wrongAnswer3: "1973", pointQuestion: 20, exam_id: nil, level_id: 15, wrongAnswer2: "1984")
Question.create(question: "¿En qué año debutó Lionel Messi?", answer: "1967", wrongAnswer1: "1993", wrongAnswer3: "1973", pointQuestion: 20, exam_id: nil, level_id: 15, wrongAnswer2: "1984")