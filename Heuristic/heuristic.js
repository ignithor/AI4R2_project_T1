function HEURISTIC(state):
    total_time ← 0

    for each crate in state.crates:
        if not crate.delivered:

            // Step 1: Time for closest available robot to reach crate
            time_to_crate ← MIN(
                distance(crate.position, mover1.position),
                distance(crate.position, mover2.position)
            ) / 10

            // Step 2: Estimate time to transport crate to loading bay
            if crate.weight ≤ 50:
                // Try to exploit two robots if both available
                if both mover robots can work together:
                    time_to_loading_bay ← crate.distance * crate.weight / 150
                else:
                    time_to_loading_bay ← crate.distance * crate.weight / 100
            else:
                // Heavy crate: requires two robots
                time_to_loading_bay ← crate.distance * crate.weight / 100

            // Step 3: Fixed loading time
            loading_time ← 4

            total_time += time_to_crate + time_to_loading_bay + loading_time

    return total_time