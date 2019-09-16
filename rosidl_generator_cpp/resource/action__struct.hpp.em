@# Included from rosidl_generator_cpp/resource/idl__struct.hpp.em
@{
from rosidl_parser.definition import ACTION_FEEDBACK_MESSAGE_SUFFIX
from rosidl_parser.definition import ACTION_FEEDBACK_SUFFIX
from rosidl_parser.definition import ACTION_GOAL_SERVICE_SUFFIX
from rosidl_parser.definition import ACTION_GOAL_SUFFIX
from rosidl_parser.definition import ACTION_RESULT_SERVICE_SUFFIX
from rosidl_parser.definition import ACTION_RESULT_SUFFIX

action_name = '::'.join(action.namespaced_type.namespaced_name())
}@
// forward declare action type dependencies
namespace action_msgs
{
namespace msg
{
struct GoalStatusArray;
}
namespace srv
{
struct CancelGoal;
}
}
namespace unique_identifier_msgs
{
namespace msg
{
template<typename AllocatorType>
struct UUID_;

struct UUID;
}
}
@{
# add forward declared dependencies so they are not included
include_directives.add("action_msgs/msg/goal_status_array.hpp")
include_directives.add("action_msgs/srv/cancel_goal.hpp")
include_directives.add("unique_identifier_msgs/msg/uuid__struct.hpp")
TEMPLATE(
    'msg__struct.hpp.em',
    package_name=package_name, interface_path=interface_path,
    message=action.goal, include_directives=include_directives)
}@

@{
TEMPLATE(
    'msg__struct.hpp.em',
    package_name=package_name, interface_path=interface_path,
    message=action.result, include_directives=include_directives)
}@

@{
TEMPLATE(
    'msg__struct.hpp.em',
    package_name=package_name, interface_path=interface_path,
    message=action.feedback, include_directives=include_directives)
}@

@{
TEMPLATE(
    'srv__struct.hpp.em',
    package_name=package_name, interface_path=interface_path,
    service=action.send_goal_service, include_directives=include_directives)
}@

@{
TEMPLATE(
    'srv__struct.hpp.em',
    package_name=package_name, interface_path=interface_path,
    service=action.get_result_service, include_directives=include_directives)
}@

@{
TEMPLATE(
    'msg__struct.hpp.em',
    package_name=package_name, interface_path=interface_path,
    message=action.feedback_message, include_directives=include_directives)
}@

@[for ns in action.namespaced_type.namespaces]@
namespace @(ns)
{

@[end for]@
struct @(action.namespaced_type.name)
{
  /// The goal message defined in the action definition.
  using Goal = @(action_name)@(ACTION_GOAL_SUFFIX);
  /// The result message defined in the action definition.
  using Result = @(action_name)@(ACTION_RESULT_SUFFIX);
  /// The feedback message defined in the action definition.
  using Feedback = @(action_name)@(ACTION_FEEDBACK_SUFFIX);

  struct Impl
  {
    /// The send_goal service using a wrapped version of the goal message as a request.
    using SendGoalService = @(action_name)@(ACTION_GOAL_SERVICE_SUFFIX);
    /// The get_result service using a wrapped version of the result message as a response.
    using GetResultService = @(action_name)@(ACTION_RESULT_SERVICE_SUFFIX);
    /// The feedback message with generic fields which wraps the feedback message.
    using FeedbackMessage = @(action_name)@(ACTION_FEEDBACK_MESSAGE_SUFFIX);

    /// The generic service to cancel a goal.
    using CancelGoalService = action_msgs::srv::CancelGoal;
    /// The generic message for the status of a goal.
    using GoalStatusMessage = action_msgs::msg::GoalStatusArray;
  };
};

typedef struct @(action.namespaced_type.name) @(action.namespaced_type.name);
@
@[for ns in reversed(action.namespaced_type.namespaces)]@

}  // namespace @(ns)
@[end for]@
