import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ground_zero_core/ground_zero_core.dart';

class MobileLoginScreen extends ConsumerStatefulWidget {
  const MobileLoginScreen({super.key});
  @override ConsumerState<MobileLoginScreen> createState() => _State();
}

class _State extends ConsumerState<MobileLoginScreen> {
  final _email = TextEditingController(); final _pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true; bool _obscure = true;

  @override void dispose() { _email.dispose(); _pass.dispose(); super.dispose(); }

  @override Widget build(BuildContext context) {
    final auth = ref.watch(authStateProvider);
    ref.listen(authStateProvider, (_, n) => n.whenOrNull(
      error: (e, _) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e'), backgroundColor: Colors.red))));

    return Scaffold(body: SafeArea(child: Center(child: SingleChildScrollView(padding: const EdgeInsets.all(24),
      child: Form(key: _formKey, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Icon(Icons.lock_outline, size: 64, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 24),
        Text(_isLogin ? 'Welcome Back' : 'Create Account', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 32),
        TextFormField(controller: _email, decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
          keyboardType: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : 'Invalid email'),
        const SizedBox(height: 16),
        TextFormField(controller: _pass, obscureText: _obscure,
          decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: () => setState(() => _obscure = !_obscure))),
          validator: (v) => v != null && v.length >= 6 ? null : 'Min 6 chars'),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: auth.isLoading ? null : () {
          if (!_formKey.currentState!.validate()) return;
          final n = ref.read(authStateProvider.notifier);
          _isLogin ? n.login(_email.text.trim(), _pass.text) : n.register(_email.text.trim(), _pass.text);
        }, child: auth.isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : Text(_isLogin ? 'Sign In' : 'Sign Up')),
        const SizedBox(height: 16),
        TextButton(onPressed: () => setState(() => _isLogin = !_isLogin),
          child: Text(_isLogin ? "Don't have an account? Sign Up" : 'Already have an account? Sign In')),
      ]))))));
  }
}