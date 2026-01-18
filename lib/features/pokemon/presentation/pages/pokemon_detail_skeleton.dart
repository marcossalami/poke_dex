import 'package:flutter/material.dart';
import 'package:poke_dex/features/pokemon/presentation/widgets/skeleton.dart';

class PokemonDetailSkeleton extends StatelessWidget {
  const PokemonDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Skeleton(height: 24, width: 24),
                Spacer(),
                Skeleton(height: 20, width: 120),
                Spacer(flex: 2),
              ],
            ),
          ),

          const Skeleton(
            height: 220,
            width: 220,
            borderRadius: BorderRadius.all(Radius.circular(120)),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Skeleton(height: 28, width: 80),
                      SizedBox(width: 8),
                      Skeleton(height: 28, width: 80),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Skeleton(height: 48, width: 80),
                      Skeleton(height: 48, width: 80),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Column(
                    children: [
                      Skeleton(height: 12, width: double.infinity),
                      SizedBox(height: 12),
                      Skeleton(height: 12, width: double.infinity),
                      SizedBox(height: 12),
                      Skeleton(height: 12, width: double.infinity),
                      SizedBox(height: 12),
                      Skeleton(height: 12, width: double.infinity),
                      SizedBox(height: 12),
                      Skeleton(height: 12, width: double.infinity),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
