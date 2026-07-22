import 'package:flutter/material.dart';

class RegistroUsuarioPage extends StatefulWidget {
  const RegistroUsuarioPage({super.key});

  @override
  State<RegistroUsuarioPage> createState() =>
      _RegistroUsuarioPageState();
}
class _RegistroUsuarioPageState extends State<RegistroUsuarioPage> {
  //=========================================================
  // GlobalKey para controlar el estado del formulario
  //=========================================================
  final _formKey = GlobalKey<FormState>();

  //=========================================================
  // Controllers para cada campo
  //=========================================================
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController =
      TextEditingController();

  //=========================================================
  // Método para crear una decoración uniforme para los campos
  //=========================================================
  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  //=========================================================
  // Validación de email
  //=========================================================
  bool _esEmailValido(String email) {
    final regex = RegExp(
      r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
    );
    return regex.hasMatch(email);
  }

  //=========================================================
  // Acción del botón Guardar
  //=========================================================
  void _guardar() {
    if (_formKey.currentState!.validate()) {
      // Imprimir datos en consola
      ElevatedButton(
  onPressed: _guardar,
  child: const Text("Guardar"),
      );
      debugPrint("======= DATOS DEL USUARIO =======");
      debugPrint("ID: ${_idController.text}");
      debugPrint("Nombre: ${_nombreController.text}");
      debugPrint("Email: ${_emailController.text}");
      debugPrint("Teléfono: ${_telefonoController.text}");
      debugPrint("Dirección: ${_direccionController.text}");

      // Mostrar mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Datos guardados correctamente"),
        ),
      );
    }
  }

  //=========================================================
  // Liberar memoria de los controllers
  //=========================================================
  @override
  void dispose() {
    _idController.dispose();
    _nombreController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Usuarios"),
        centerTitle: true,
      ),

      //=====================================================
      // SingleChildScrollView evita problemas con el teclado
      //=====================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
      

        child: Form(

          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 80,backgroundColor: const Color.fromARGB(255, 241, 90, 140),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage("https://jujoxqwxchkgzyqgbgad.supabase.co/storage/v1/object/sign/proyecto%20x/logo%20en%20PDF%203_page-0001.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtl eV83OTFkYzBiNi1jY2E1LTQwZmItOWVlOS0xNWY1YTMyZDM4OTEiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJwcm95ZWN0byB4L2xvZ28gZW4gUERGIDNfcGFnZS0wMDAxLmpwZyIsInNjb3BlIjoiZG93bmxvYWQiLCJpYXQiOjE3ODQ3MjczNDQsImV4cCI6MTgxNjI2MzM0NH0.4GUxTEuPLlEb_2kdER4ec3Dp8RWwu0CYdIHAMY4nXjE"),),),
            ),
              //------------------------------------------------
              // Campo ID
              //------------------------------------------------
              TextFormField(
                controller: _idController,
                decoration: _inputDecoration(
                  label: "ID",
                  hint: "Ingrese el ID",
                  icon: Icons.badge_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "El ID es obligatorio";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              //------------------------------------------------
              // Campo Nombre
              //------------------------------------------------
              TextFormField(
                controller: _nombreController,
                decoration: _inputDecoration(
                  label: "Nombre",
                  hint: "Ingrese el nombre",
                  icon: Icons.person_outline,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "El nombre es obligatorio";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              //------------------------------------------------
              // Campo Email
              //------------------------------------------------
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  label: "Email",
                  hint: "ejemplo@correo.com",
                  icon: Icons.email_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "El email es obligatorio";
                  }

                  if (!_esEmailValido(value.trim())) {
                    return "Ingrese un email válido";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              //------------------------------------------------
              // Campo Teléfono
              //------------------------------------------------
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  label: "Teléfono",
                  hint: "Ingrese el teléfono",
                  icon: Icons.phone_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "El teléfono es obligatorio";
                  }

                  if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                    return "Solo se permiten números";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              //------------------------------------------------
              // Campo Dirección
              //------------------------------------------------
              TextFormField(
                controller: _direccionController,
                maxLines: 2,
                decoration: _inputDecoration(
                  label: "Dirección",
                  hint: "Ingrese la dirección",
                  icon: Icons.location_on_outlined,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "La dirección es obligatoria";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              //------------------------------------------------
              // Botón Guardar
              //------------------------------------------------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _guardar,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Guardar",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
