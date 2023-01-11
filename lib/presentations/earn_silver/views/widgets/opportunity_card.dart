import 'package:flutter/material.dart';

import '../../../../data/models/getAllEvents_model.dart';

class OpportunityCard extends StatelessWidget {
  final Event event;
  const OpportunityCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/imgplaceholder.png',
            image: event.eventImageUrl ?? "",
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    event.eventName ?? "Hunter Creek Restoration",
                    style: TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    event.eventDescription ??
                        "Volunteer time to help Aspen Parks & Recreation repair Hunter Creek Loop trail.",
                    style: const TextStyle(fontSize: 9),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
