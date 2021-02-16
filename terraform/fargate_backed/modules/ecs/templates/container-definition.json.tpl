[
	{
	    "name": "${container_name}",
		"portMappings": [
			{
				"hostPort": ${host_port},
				"containerPort": ${container_port},
				"protocol": "tcp"
			}
		],
		"cpu": ${cpu_unit},
		"memory": ${hard_limit},
        "memoryReservation": ${soft_limit},
		"image": "${image}",
		"essential": true,
		"healthCheck": {
			"timeout": ${health_check_timeout},
			"interval": ${health_check_interval},
			"retries": ${health_check_retries},
			"command": [
				"[ \"CMD-SHELL\"",
				"\"curl -f http://localhost${health_check_path} || exit 1\" ]"
			]
		},
		"logConfiguration": {
			"logDriver": "awslogs",
			"options": {
				"awslogs-group": "${log_group_name}",
				"awslogs-region": "${log_group_region}",
				"awslogs-stream-prefix": "${log_stream_prefix}"
			}
		}
	}
]
