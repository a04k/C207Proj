import random
import datetime

def genData():
    downtown_streets = ["El Tahrir", "Talaat Harb", "Al Falaky", "26 July St", "Champeleon", "Sherif", "Adly"]
    zamalek_streets = ["Abou El Feda", "Bahgat Ali", "Taha Hussein", "Gezira", "Hassan Sabry", "Shagaret Al Dor", "Hassan Assem", "Ahmed Heshmat", "kamal Al Tawil", "Mohammed Mazhar"]
    imbaba_streets = ["18St. , ElTahrir City", "28St. ,ElTahrir City", "Talaat Harb", "Mamdouh Salem"]
    al_doqi_streets = ["Shaheen", "Gad Eid", "Hassan Ramadan"]
    helopolis_streets = ["Baghdad", "Al Merghany", "Al Ahram", "Al Nozha", "Al Hegaz", "Salah El Din"]
    shobra_streets = ["Shobra St.", "Ahmed Helmy", "Doletyan", "Rod El Farag", "Al Teraa Al Boulakeya", "Kholousi", "Al Khamrawaya", "15 May"]
    salam_streets = ["Gamal Abdel Nasser", "El Sadat"]
    maadi_streets = ["Al Saad Al Aaly","Al Nahda","Damascus","Oraby", "9 St.","Al Kanal","151 St.", "Al Nadi"]
    area = random.choice(['Downtown', 'Zamalek', 'Imbaba', 'Al Doqi', 'Heliopolis', 'Shobra', 'Al-Salam', 'Maadi'])
    street = ""
    random_number = random.randint(1, 100) #for building no 
    if area == 'Downtown':
        street = random.choice(downtown_streets)
        city = 'Cairo'
    elif area == 'Zamalek':
        street = random.choice(zamalek_streets)
        city = 'Cairo'
    elif area == 'Imbaba':
        street = random.choice(imbaba_streets)
        city = 'Giza'
    elif area == 'Al Doqi':
        street = random.choice(al_doqi_streets)
        city = 'Giza'
    elif area == 'Heliopolis':
        street = random.choice(helopolis_streets)
        city = 'Cairo'
    elif area == 'Shobra':
        street = random.choice(shobra_streets)
        city = 'Cairo'
    elif area == 'Al-Salam':
        street = random.choice(salam_streets)
        city = 'Cairo'
    elif area == 'Maadi':
        street = random.choice(maadi_streets)
        city= 'Cairo'
   #name part
    nameM = ["Ahmed","Seif","Sherif","Marawan","Ehab","Kareem","Omar","Amr","Amir","Zeyad","Rashad","Abdallah","Abdelrahman","Ali","Wael","Mohamed","Mahmoud","Yousif","Mostafa","Adham","Ibrahim","Eyad","Abdalaziz","Haytham"]
    nameF = ["Aya","Amal","Amani","Omnya","Arwa","Nour","Rahma","Shahd","Noureen","Mariam","Nada","Esraa","Hager","Nourhan","Yasmin","Yara","Dina","Hana","Salma","Toaa","Eman"]  
    gender = random.choice(['M','F'])  
    if gender == 'M':
        first_name = random.choice(nameM)
    else:
        first_name = random.choice(nameF)
  
    L_name = [ "Mohamed","Khaled","Ashraf","Waleed","Emad","Sayed","Yaser","Magdy","Adel","Nader","Sobhi","Hani","Hassan","Farag","Salah","Ghanim","Khalil","Zakaria","Fawzi","Ezzat" ]
    last_name = random.choice(L_name)

    return first_name, last_name , gender , f"{random_number} {street}, {area}, {city}"


def ssnGen():
    while True:
        global current_ssn
        current_ssn += 1
        if current_ssn not in used_ssn:
            used_ssn.add(current_ssn)
            return current_ssn

used_ssn = set()
current_ssn = 94

def genPerson():
    Fname, Lname, gender, address = genData()
    name = Fname + Lname
    SSN = ssnGen()
    person = {
        'SSN': SSN,
        'Fname': Fname,
        'Lname': Lname,
        'address': address,
        'email': name + str(random.randint(0, 420)) + '@' + random.choice(['gmail.com', 'hotmail.com', 'outlook.com']),
        'phone_number': random.choice(['010', '011', '012', '015']) + ''.join([str(digit) for digit in random.sample(range(10), 8)]),
        'birthdate': datetime.date(random.randint(1994, 2005), random.randint(1, 12), random.randint(1, 28)),
        'gender': gender
    }
    return person

personData = [genPerson() for _ in range(10)]

playerData = [{'SSN': person['SSN'], 'Salary': random.randint(45000, 90000), 'SportName': 'Kung Fu'} for person in personData]
memberData = [{'SSN': person['SSN'], 'Membership.SD':datetime.date(random.randint(2015, 2023), random.randint(1, 12), random.randint(1, 28))} for person in personData]
tsData = [{'SSN': person['SSN']} for person in personData]

person_insert_statement = "INSERT INTO Person (SSN, Fname, Lname, Address, Phone, Bdate, Gender, Email) VALUES\n "

for person in personData:
    values = f'({person['SSN']}, "{person['Fname']}", "{person['Lname']}", "{person['address']}", "{person['phone_number']}", "{person['birthdate']}", "{person['gender']}", "{person['email']}"),\n'
    person_insert_statement += values

player_insert_statement = "INSERT INTO Pro_Player (Player_SSN, Salary, SportName) VALUES\n "

for player in playerData:
    values = f"({player['SSN']}, {player['Salary']}, '{player['SportName']}'),\n"
    player_insert_statement += values

member_insert_statement = "INSERT INTO member (Member_SSN, MembershipStartDate) VALUES\n "

for member in memberData:
  values = f'({member["SSN"]}, "{member["Membership.SD"]}"),\n'
  member_insert_statement += values


totalinsert = person_insert_statement + member_insert_statement+ player_insert_statement


with open('KFPData.txt', 'w') as file:
    file.write(totalinsert)


print("-> done")
