import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/Profile_Page/ProfilePage.dart';


class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Add Product",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                height: 300,
                width: 420,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Homepage/shoes.jpg"),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(5, 5),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Add Bio..",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Price",
                        hintStyle: TextStyle(
                          color: Colors.black54,

                        ),
                        filled: true,

                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide(color: Colors.grey, width: 2)
                        )

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Category",
                            hintStyle: TextStyle(
                              color: Colors.black54,

                            ),
                            filled: true,

                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),

                                borderSide: BorderSide(color: Colors.grey, width: 2)
                            )
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            Padding(
                padding: const EdgeInsets.only(right: 10, top: 30, left: 10),
                child: SizedBox(
                  width: 180,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profilepage())

                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: Text("AddProduct",
                        style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700
                        ),
                      )
                  ),
                ),
            )


          ],
        ),
      ),
    );
  }
}
