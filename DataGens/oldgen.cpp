#include<iostream>
using namespace std;
void Location() {
	string Zamalek[10] = { "Abou El Feda","Bahgat Ali","Taha Hussein","Gezira","Hassan Sabry","Shagaret Al Dor","Hassan Assem","Ahmed Heshmat","kamal Al Tawil","Mohammed Mazhar" },
		Imbaba[4] = { "18St ElTahrir City","28St ElTahrir City","Talaat Harb","Mamdouh Salem" },
		Al_Doqi[3] = { "Shaheen","Gad Eid","Hassan Ramadan" };
	int num = (rand() % 19) +1;
	cout << num << ' ';
	int x = rand() % 9;
	if (x < 6) {
		int z = rand() % 9;
		cout << Zamalek[z] << " St El-Zamalek','";
	}
	else if (x >= 6 && x < 9) {
		int i = rand() % 3;
		cout << Imbaba[i] << " Imbaba','";
	}
	else if (x == 9) {
		int a = rand() % 2;
		cout << Al_Doqi[a] << " St Al-Doqi','";
	}

}
void phone() {
	int x = (rand() % 3) + 1;
	switch (x){
	case 1: {cout << "010";break;}
	case 2: {cout << "011";break;}
	case 3: {cout << "012";break;}
	case 4: {cout << "015";break;}
	}
	for (int i = 0;i < 8;i++) {
		int y = rand() % 9;
		cout << y;
	}
	cout << "','";
}
void Date() {
	int x = rand() % 13, y = rand() % 12, z = rand() % 28;
	cout << 1991 + x << '-' << y << '-' << z << "','";
}
void main() {
	string nameM[20] = { "Ahmed","Seif","Sherif","Kariem","Omer","Amr","Amir","Zeyad","Rashad","Abdallah","Abdelrahman","Ali","Wael","Mohamed","Mahmod","Yousif","Mostafa","Adham","Ibrahim","Eyad" },
		nameF[15] = { "Aya","Arwa","Nour","Rahma","Shahd","Noureen","Mariem","Nada","Esraa","Hager","Nourhan","Yasmin","Yara","Dina","Hana" },
		nameL[20] = { "Mohamed","Khaled","Ashraf","Waleed","Emad","Sayed","Yaser","Magdy","Adel","Nader","Sobhi","Hani","Hassan","Farag","Salah","Ghanim","Khalil","Zakaria","Fawzi","Ezzat" };
	int x = 130, y = 1;

	while (y > 0) {
		cout << '(' << x << ',';
		int z = rand() % 3;
		if (z == 0) {
			int f = rand() % 14, l = rand() % 19;
			cout << "'" << nameF[f] << "','" << nameL[l] << "','";
			Location();
			phone();
			Date();
			cout << "F'),";
		}
		else {
			int m = rand() % 19, l = rand() % 19;
			cout << "'" << nameM[m] << "','" << nameL[l] << "','";
			Location();
			phone();
			Date();
			cout << "M'),";
		}
		x++;
		cout << endl << endl;
		cout << "Press one to continue";
		cin >> y;
		cout << endl;
	}
}