import 'package:coffee/core/injection/dependency_injection.dart';
import 'package:coffee/features/coffee/bloc/local_bloc/fetching/fetch_local_coffee_bloc.dart';
import 'package:coffee/features/coffee/bloc/local_bloc/inserting/insert_local_coffee_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomDrawer extends StatelessWidget {
  final String title;
  final Widget content;
  const BottomDrawer({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<InsertLocalCoffeeBloc>(),
      child: BlocListener<InsertLocalCoffeeBloc, InsertLocalCoffeeState>(
        listener: (context, state) {
          if (state.status == InsertCoffeeStatus.success) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Successfully saved")));
            // context.read<FetchLocalCoffeeBloc>().add(FetchLocalCoffee()); //uses sqflite method to insert
            context.read<FetchLocalCoffeeBloc>().add(FetchLocalCoffeeViaXml());
            Navigator.pop(context);
          }

          if (state.status == InsertCoffeeStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error : ${state.errorMessage}")),
            );
            Navigator.pop(context);
          }
        },
        child: Container(
          width: double.infinity,
          height: 300,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(223, 215, 193, 1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
