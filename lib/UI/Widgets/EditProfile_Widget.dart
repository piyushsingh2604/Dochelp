import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EditprofileWidget extends StatelessWidget {
  const EditprofileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        centerTitle: true,
        title: Text("Edit Profile",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 17),),
      
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: const Color.fromARGB(29, 158, 158, 158),thickness: 4,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 125,
                  child: Stack(
                    children: [  Container(
                        height: 120,
                        width: 120,
        decoration: BoxDecoration(
                          color: Colors.green,
        borderRadius: BorderRadius.circular(120)
        ),                    ),
                      Positioned(
                        top: 75,
                        right: 2,
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            child: Center(
                              child: Icon(Icons.camera_alt_outlined,color: Colors.white,size: 16,),
                            ),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              color: Color(0xFF27B4E4),
                            ),
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                )
              ],
            ),
               Padding(
              padding: const EdgeInsets.only(left: 40,top: 35),
              child: Text("Username",style: TextStyle(fontSize: 11,color: Colors.grey,fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,top: 2),
              child: Text("Satyam",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,top: 10),
              child: Text("Email Address",style: TextStyle(fontSize: 11,color: Colors.grey,fontWeight: FontWeight.w500),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,top: 2),
              child: Text("Test@gmail.com",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
            ),
                         Padding(
              padding: const EdgeInsets.only(left: 40,top: 20),
              child: Text("Name",style: TextStyle(fontSize: 11,color: Color(0xFF27B4E4),fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 0),
              child: SizedBox(
                height: 40,
                child: TextField(cursorHeight: 20,
                  decoration: InputDecoration(
        
                  ),
                ),
              ),
            ),
                      Padding(
              padding: const EdgeInsets.only(left: 40,top: 20),
              child: Text("Number",style: TextStyle(fontSize: 11,color:Color(0xFF27B4E4),fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 0),
              child: SizedBox(
                height: 40,
                child: TextField(cursorHeight: 20,
                  decoration: InputDecoration(suffixIcon: Icon(Icons.perm_contact_cal_outlined),
                  suffixIconColor: Colors.grey
        
                  ),
                ),
              ),
            ),
               Padding(
              padding: const EdgeInsets.only(left: 40,top: 20),
              child: Text("Location",style: TextStyle(fontSize: 11,color: Color(0xFF27B4E4),fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 0),
              child: SizedBox(
                height: 40,
                child: TextField(cursorHeight: 20,
              
                  decoration: InputDecoration(
        
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 40),
              child: InkWell(
                onTap: (){},
                child: Container(
                  child: Center(
                    child: Text("UPDATE PROFILE",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                  ),
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xFF27B4E4),
                  ),
                ),
              ),
            ),
            Gap(50)
          ],
        ),
      ),
    );
  }
}