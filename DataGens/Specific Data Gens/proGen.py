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
    gender = random.choice(['M'])  
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
current_ssn = 108

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
        'birthdate': datetime.date(random.randint(1987, 2005), random.randint(1, 12), random.randint(1, 28)),
        'gender': gender
    }
    return person

personData = [genPerson() for _ in range(6)]

proData = [{'SSN': person['SSN'],'Management_name': "Sport" ,'Salary':random.randint(120000, 150000), 'ContractStart':datetime.date(random.randint(2020, 2023), random.randint(1, 12), random.randint(1, 6)), 'ContractEnd':datetime.date(random.randint(2024, 2025), random.randint(1, 12), random.randint(1, 28))} for person in personData]

pro_insert_statement = "INSERT INTO Pro (Coach_SSN, Management_Name, Salary, ContractStart, ContractEnd) VALUES\n "

for pro in proData:
    values = f'({pro['SSN']},"{pro['Management_name']}",{pro['Salary']},"{pro['ContractStart']}","{pro['ContractEnd']}"),\n'
    pro_insert_statement += values


totalinsert = pro_insert_statement


with open('CoachProData3.txt', 'w') as file:
    file.write(totalinsert)


print("-> done")
