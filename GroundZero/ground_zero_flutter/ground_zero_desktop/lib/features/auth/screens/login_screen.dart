import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_zero_core/ground_zero_core.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;

  @override void dispose() { _email.dispose(); _pass.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider);
    ref.listen(authStateProvider, (_, next) => next.whenOrNull(
      error: (e, _) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')))));

    return Scaffold(body: Center(child: SizedBox(width: 400, child: Card(child: Padding(
      padding: const EdgeInsets.all(32),
      child: Form(key: _formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Admin Login', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 24),
        TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email)),
          validator: (v) => v != null && v.contains('@') ? null : 'Invalid email'),
        const SizedBox(height: 16),
        TextFormField(controller: _pass, obscureText: _obscure,
          decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _obscure = !_obscure))),
          validator: (v) => v != null && v.length >= 6 ? null : 'Min 6 chars'),
        const SizedBox(height: 24),
        SizedBox(width: double.infinity, height: 48, child: FilledButton(
          onPressed: auth.isLoading ? null : () {
            if (_formKey.currentState!.validate()) ref.read(authStateProvider.notifier).login(_email.text.trim(), _pass.text);
          },
          child: auth.isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Sign In'),
        )),
      ])))))));
  }
}