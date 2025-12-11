package scheduler_util

import (
	"strings"

	v1 "k8s.io/api/core/v1"
)

const NonPreemptibleKey = "scheduler.kai/non-preemptible"

func IsNonPreemptible(pod *v1.Pod) bool {
	// Prefer label, but also support annotation with the same key.
	val, ok := pod.Labels[NonPreemptibleKey]
	if !ok {
		val = pod.Annotations[NonPreemptibleKey]
	}

	switch strings.ToLower(strings.TrimSpace(val)) {
	case "true", "1", "yes", "y":
		return true
	default:
		return false
	}
}
